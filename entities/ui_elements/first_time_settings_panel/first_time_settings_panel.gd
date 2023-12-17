extends Panel

const UILanguages = [
	"English"
]

const LearningLanguages = [
	"Russian",
	"English"
]

func _ready():
	for language_name in UILanguages:
		$"%UILanguageOptionButton".add_item(language_name)
	
	for language_name in LearningLanguages:
		$"%NativeLanguageOptionButton".add_item(language_name)
		$"%LanguageToLearnOptionButton".add_item(language_name)
	
	$"%LanguageToLearnOptionButton".select(1)
	

func _on_SaveButton_pressed():
	Settings.set_language_to_learn($"%LanguageToLearnOptionButton".get_item_text($"%LanguageToLearnOptionButton".get_selected_id()))
	Settings.set_ui_language($"%UILanguageOptionButton".get_item_text($"%UILanguageOptionButton".get_selected_id()))
	Settings.set_native_language($"%NativeLanguageOptionButton".get_item_text($"%NativeLanguageOptionButton".get_selected_id()))
	hide()
