extends Node

const _SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
const _DatabasePath = "res://entities/database/database.db"
var _db: _SQLite


func _ready():
	_db = _SQLite.new()
	_db.path = _DatabasePath


func _query(query_string: String):
	_db.open_db()
	_db.query(query_string)
	_db.close_db()


func add_category(category_name: String):
	_query("INSERT INTO categories (name) VALUES ('%s')" % [category_name])


