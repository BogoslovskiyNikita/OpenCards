extends Control

const CategoryListItemScene = preload("res://entities/ui_elements/category_list_item/category_list_item.tscn")

func _ready():
	DatabaseManager.connect("category_added", self, "refresh_categories_list")
	refresh_categories_list()
	

func refresh_categories_list():
	Utils.queue_free_children($"%VBoxCategoriesContainer")
	for category in DatabaseManager.get_all_categories():
		var new_item = CategoryListItemScene.instance()
		new_item.set_category_name(category.category_name)
		$"%VBoxCategoriesContainer".add_child(new_item)


func _on_NewCategoryButton_pressed():
	$"%NewCategoryPopUp".open()
