extends Node

const _SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
const _DatabasePath = "res://entities/database/database.db"

var _db: _SQLite

signal category_added

class Category: ## TODO: Come up with a better name
	var category_name: String ##TODO: replace 'category_name' with 'name'
	var id: int
	
	func _init(_id: int, _category_name: String):
		id = _id
		category_name = _category_name
	
	func _to_string():
		return "<Category '%s' with id %d>" % [category_name, id]


class WordModel:
	var id: int
	var word: String
	var translation: String
	var description: String
	
	func _init(_id: int, _word: String, _translation: String, _description: String):
		id = _id
		word = _word
		translation = _translation
		description = _description
		
	func _to_string():
		return "<Word '%s' with id %d>" % [word, id]


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


func get_category(id: int) -> Category:
	_query("SELECT * FROM categories WHERE ID = %d" % id)
	var result = _db.query_result[0]
	return Category.new(result.id, result.name)


func get_words_count(category_id: int) -> int:
	## TODO: Find better name for category column
	var query_string = "SELECT COUNT(*) as category_count FROM words WHERE category = %d" % category_id
	_query(query_string)
	return _db.query_result[0].category_count


func add_word(word: String, translastion: String, category: int, description: String = ""):
	_query("INSERT INTO words (word, translation, description, category) VALUES ('%s', '%s', '%s', %d)" % [word, translastion, description, category])


func get_words(category_id: int) -> Array:
	_query("SELECT * FROM words WHERE category = %d" % category_id)
	var query_result = _db.query_result
	var result = Array()
	for record in query_result:
		var word_model = WordModel.new(record.id, record.word, record.translation, record.description)
		result.append(word_model)
	return result
