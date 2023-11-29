extends Control

const ListItemScene = preload("res://entities/ui_elements/list_item/list_item.tscn")

func _ready():
	DatabaseManager.connect("category_added", self, "refresh_categories_list")
	refresh_categories_list()
	

func refresh_categories_list():
	var list_container = $"%CategoriesContainer".get_node("VBoxContainer")
	
	Utils.queue_free_children(list_container)
	for category in DatabaseManager.get_all_categories():
		var new_item = ListItemScene.instance()
		new_item.set_label_text(category.category_name)
		new_item.set_id(category.id)
		new_item.connect("selected", self, "on_item_selected")
		list_container.add_child(new_item)


func on_item_selected(id: int):
	ScreenManager.open_category_screen(id)
	

func _on_NewCategoryButton_pressed():
	$"%NewCategoryPopUp".open()

