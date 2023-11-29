extends Node

const _SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
const _DatabasePath = "res://entities/database/database.db"

var _db: _SQLite

signal category_added

class Category:
	var category_name: String
	var id: int
	
	func _init(_id: int, _category_name: String):
		id = _id
		category_name = _category_name
	
	func _to_string():
		return "<Category '%s' with id %d>" % [category_name, id]


func _ready():
	_db = _SQLite.new()
	_db.path = _DatabasePath


## TODO: add possibility to instantly return query result
func _query(query_string: String):
	_db.open_db()
	_db.query(query_string)
	_db.close_db()


func add_category(category_name: String):
	_query("INSERT INTO categories (name) VALUES ('%s')" % [category_name])
	emit_signal("category_added")


func get_all_categories():
	_query("SELECT * FROM CATEGORIES")
	var categories_from_db = _db.query_result
	var result = Array()
	for category in categories_from_db: ## TODO: refactor
		result.append(Category.new(category.id, category.name))
	return result


func get_category(id: int):
	_query("SELECT * FROM categories WHERE ID = %d" % id)
	var result = _db.query_result[0]
	return Category.new(result.id, result.name)
