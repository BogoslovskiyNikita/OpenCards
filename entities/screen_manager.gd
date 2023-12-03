extends Node

onready var category_screen = preload("res://entities/screens/category_screen/category_screen.tscn").instance()
onready var categories_catalogue_screen
onready var learn_screen = preload("res://entities/screens/learn_screen/learn_screen.tscn").instance()
onready var current_screen

var main_vbox_container: VBoxContainer


func open_category_screen(category_id: int):
	category_screen.setup(category_id)
	change_screen(category_screen)


func open_categories_catalogue_screen():
	change_screen(categories_catalogue_screen)


func open_learn_screen():
	change_screen(learn_screen)


func change_screen(new_screen: Node):
	main_vbox_container.remove_child(current_screen)
	main_vbox_container.add_child(new_screen)
	current_screen = new_screen
	main_vbox_container.move_child(current_screen, 0)
