extends Node

onready var library_screen: Control = get_tree().root.get_node("Main")
onready var category_screen = preload("res://entities/screens/category_screen/category_screen.tscn").instance()


func open_category_screen(category_id: int):
	get_tree().root.remove_child(library_screen)
	category_screen.setup(category_id)
	get_tree().root.add_child(category_screen)

