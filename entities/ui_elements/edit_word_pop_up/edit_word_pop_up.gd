extends Panel

enum Mode {NEW_WORD, EDIT_WORD}

var mode = Mode.NEW_WORD
var category_id: int

signal word_added

func _ready():
	set_label_hints()
	Translator.connect("translation_completed", $"%TranslationLineEdit", "set_text")


func set_label_hints():
	$"%WordLineEdit".placeholder_text += " (%s)" % Settings.get_language_to_learn()
	$"%DescriptionLineEdit".placeholder_text += " (%s)" % Settings.get_language_to_learn()
	$"%TranslationLineEdit".placeholder_text += " (%s)" % Settings.get_native_language()


func open(_category_id: int, mode: int = Mode.NEW_WORD):
	category_id = _category_id
	show()


func close():
	$"%WordLineEdit".clear()
	$"%TranslationLineEdit".clear()
	$"%DescriptionLineEdit".clear()
	hide()


func _on_SaveButton_pressed():
	if mode == Mode.NEW_WORD:
		DatabaseManager.add_word(
			$"%WordLineEdit".text,
			$"%TranslationLineEdit".text,
			category_id,
			$"%DescriptionLineEdit".text
			)
	emit_signal('word_added')
	close()


func _on_WordLineEdit_text_changed(new_text: String):
	if new_text.empty():
		$"%TranslationLineEdit".clear()
		return
	
	$"%WordTranslationTimer".start()


func _on_WordTranslationTimer_timeout():
	var text_to_translate = $"%WordLineEdit".text
	if text_to_translate.empty():
		return
	
	Translator.translate(text_to_translate)
