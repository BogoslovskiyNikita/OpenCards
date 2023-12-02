extends Control

const CategoriesListItemScene = preload("res://entities/ui_elements/categories_list_item/categories_list_item.tscn")

func _ready():
	DatabaseManager.connect("category_added", self, "refresh_categories_list")
	DatabaseManager.connect("category_deleted", self, "refresh_categories_list")
	refresh_categories_list()
	ScreenManager.current_screen = self ## TODO: replace spaghetti code
	ScreenManager.categories_catalogue_screen = self
	ScreenManager.main_vbox_container = get_parent()


func refresh_categories_list():
	var list_container = $"%CategoriesContainer".get_node("VBoxContainer")
	
	Utils.queue_free_children(list_container)
	for category in DatabaseManager.get_all_categories():
		var new_item = CategoriesListItemScene.instance()
		new_item.set_label_text(category.category_name)
		new_item.set_id(category.id)
		new_item.connect("selected", self, "on_item_selected")
		list_container.add_child(new_item)


func on_item_selected(id: int):
	ScreenManager.open_category_screen(id)
	

func _on_NewCategoryButton_pressed():
	$"%NewCategoryPopUp".open()

