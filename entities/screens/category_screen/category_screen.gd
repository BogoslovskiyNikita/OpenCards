extends Control

const ListItemScene = preload("res://entities/ui_elements/list_item/list_item.tscn")

var category_id

func setup(_category_id: int):
	category_id = _category_id
	
	set_category_info()
	refresh_words_list()
	
	$"%EditWordPopUp".connect("word_added", self, "set_category_info")
	$"%EditWordPopUp".connect("word_added", self, "refresh_words_list")
	

func set_category_info():
	var category = DatabaseManager.get_category(category_id)
	$"%CategoryInfo".text = "Category: %s, %d words" % [category.category_name, DatabaseManager.get_words_count(category_id)]


func _on_NewWordButton_pressed():
	$"%EditWordPopUp".open(category_id)


func refresh_words_list():
	$"%ScrollingList".clear()
	for word_model in DatabaseManager.get_words(category_id):
		var new_item = ListItemScene.instance()
		new_item.set_label_text(word_model.word)
		new_item.set_id(word_model.id)
		$"%ScrollingList".add_item(new_item)
