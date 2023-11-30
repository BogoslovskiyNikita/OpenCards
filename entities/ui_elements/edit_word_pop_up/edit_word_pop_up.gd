extends Panel

enum Mode {NEW_WORD, EDIT_WORD}

var mode = Mode.NEW_WORD
var category_id: int

signal word_added

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
