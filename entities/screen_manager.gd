extends Node

onready var category_screen = preload("res://entities/screens/category_screen/category_screen.tscn").instance()
onready var current_screen

var main_vbox_container: VBoxContainer

func open_category_screen(category_id: int):
	category_screen.setup(category_id)
	change_screen(category_screen)

func change_screen(new_screen: Node):
	main_vbox_container.remove_child(current_screen)
	main_vbox_container.add_child(new_screen)
	current_screen = new_screen
	main_vbox_container.move_child(current_screen, 0)
