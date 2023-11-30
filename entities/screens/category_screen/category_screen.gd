extends Control

var category_id

func setup(_category_id: int):
	category_id = _category_id
	set_category_info()
	$"%EditWordPopUp".connect("word_added", self, "set_category_info")


func set_category_info():
	var category = DatabaseManager.get_category(category_id)
	$"%CategoryInfo".text = "Category: %s, %d words" % [category.category_name, DatabaseManager.get_words_count(category_id)]


func _on_NewWordButton_pressed():
	$"%EditWordPopUp".open(category_id)
