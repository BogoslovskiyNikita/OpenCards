extends Control

const LearningCardScene = preload("res://entities/ui_elements/learning_card/learning_card.tscn")

var cards = []

func _ready():
	_set_up_categories()


func _set_up_categories():
	var items = ["Mixed"]
	var items_metadata = [-1] # Crutch: set -1 id for "Mixed categories" 
	for category_model in DatabaseManager.get_all_categories():
		items.append(category_model.category_name)
		items_metadata.append(category_model.id)
	for index in range(items.size()):
		$"%CategoriesOptionButton".add_item(items[index])
		$"%CategoriesOptionButton".set_item_metadata($"%CategoriesOptionButton".get_item_id(index), items_metadata[index])
	_on_CategoriesOptionButton_item_selected(0)


func _on_CategoriesOptionButton_item_selected(index):
	var item_db_id = $"%CategoriesOptionButton".get_selected_metadata()
	$"%WordsAmountSpinBox".allow_greater = true
	if item_db_id == -1:
		$"%WordsAmountSpinBox".value = DatabaseManager.get_all_words_count()
	else:
		$"%WordsAmountSpinBox".value = DatabaseManager.get_words_count(item_db_id)
	$"%WordsAmountSpinBox".allow_greater = false
	$"%WordsAmountSpinBox".max_value = $"%WordsAmountSpinBox".value


## TODO: add toast when $"%WordsAmountSpinBox" is 0
func _start_learning():
	var category_db_id = $"%CategoriesOptionButton".get_selected_metadata()
	if category_db_id == -1:
		category_db_id = null
	
	$"%LearningParamsPanel".hide()
	_generate_cards(LearningManager.generate_random_words($"%WordsAmountSpinBox".value, category_db_id))


func _generate_cards(word_models: Array):
	for word_model in word_models:
		var new_card = LearningCardScene.instance()
		new_card.init(word_model.id)
		new_card.hide()
		add_child(new_card)
		cards.append(new_card)
	
	cards[0].show()

	## Show every card after dissaperance of previous
	for i in range(cards.size()):
		if i != cards.size() - 1:
			cards[i].connect("dissaperance_animation_started", cards[i + 1], "show")
