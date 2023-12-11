extends Control

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
	print(LearningManager.generate_random_words($"%WordsAmountSpinBox".value, category_db_id))
	
