extends Node

const _SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
const _TemplateDatabasePath = "res://entities/database/template_database.db"
const _UserDatabasePath = "user://data/database.db"

var _db: _SQLite
# TODO: remove it

signal category_added
signal category_deleted
signal word_delted

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
	print(1)
	copy_db_if_needed()
	_db = _SQLite.new()
	_db.path = _UserDatabasePath


## TODO: not copying and earsing, but megrating
## Casese when we need to copy db:
## - User's DB not exists
## - App's DB version is newer
func copy_db_if_needed():
	print(2)
	if not Utils.file_exists(_UserDatabasePath):
		_copy_db_to_user_folder()
	var app_db_version = get_database_version(_TemplateDatabasePath)
	var user_db_version = get_database_version(_UserDatabasePath)
	print('compare versions:', app_db_version > user_db_version)
	# add "DatabaseVersion" field?
	print(3)


## TODO: Refactor
func _copy_db_to_user_folder():
	print(4)
	var data_folder_path = "user://data"
	if not Directory.new().dir_exists(data_folder_path):
		Directory.new().make_dir(data_folder_path)
	Directory.new().copy(_TemplateDatabasePath, _UserDatabasePath)
	print(5.2)

## TODO: add possibility to instantly return query result
func _query(query_string: String):
	_db.open_db()
	_db.query(query_string)
	_db.close_db()


func add_category(category_name: String):
	_query("INSERT INTO categories (name) VALUES ('%s')" % [category_name])
	emit_signal("category_added")


func get_all_categories():
	_query("SELECT * FROM categories")
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


func get_all_words_count() -> int:
	var query_string = "SELECT COUNT(*) as category_count FROM words"
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


func get_word(word_id: int) -> WordModel:
	_query("SELECT * FROM words WHERE id = %d" % word_id)
	var query_result = _db.query_result[0]
	var word_model = WordModel.new(
		query_result.id,
		query_result.word,
		query_result.translation,
		query_result.description
	)
	return word_model
	
	

func delete_word(word_id: int):
	_query("DELETE FROM words WHERE id = %d" % word_id)
	emit_signal("word_delted")


func delete_category(category_id: int):
	var words_in_category = get_words(category_id)
	for word_model in words_in_category:
		delete_word(word_model.id)
	_query("DELETE FROM categories WHERE id = %d" % category_id)
	emit_signal("category_deleted")


func update_correct_answers_count(word_id: int):
	pass


func get_random_words(amount: int, category_id = null):
	var correct_answers_to_learn = get_constant('correct_answers_to_learn')
	if category_id:
		_query("SELECT * FROM words WHERE category = %d AND correct_answers_count < %d ORDER BY RANDOM() LIMIT %d" % [category_id, correct_answers_to_learn,amount])
	else:
		_query("SELECT * FROM words WHERE correct_answers_count < %d ORDER BY RANDOM() LIMIT %d" % [correct_answers_to_learn, amount])
	
	var result = Array()
	
	for record in _db.query_result:
		var word_model = WordModel.new(record.id, record.word, record.translation, record.description)
		result.append(word_model)
	return result


func increase_correct_answers_count(word_id: int):
	_query("UPDATE words SET correct_answers_count = correct_answers_count + 1 WHERE id = %d" % word_id)


func count_words_to_learn(category_id = null) -> int:
	var correct_answers_to_learn = get_constant('correct_answers_to_learn')
	if category_id:
		_query("SELECT COUNT(*) FROM words WHERE correct_answers_count < %d AND category = %d" % [correct_answers_to_learn, category_id])
	else:
		_query("SELECT COUNT(*) FROM words WHERE correct_answers_count < %d" % correct_answers_to_learn)
	return _db.query_result[0].get('COUNT(*)')


func count_learned_words() -> int:
	return get_all_words_count() - count_words_to_learn()


func get_constant(constant_name: String):
	_query("SELECT value FROM constants WHERE name = '%s'" % constant_name)
	var constant = _db.query_result[0].value
	if constant:
		return constant
	else:
		push_error("Constant %s not found" % constant_name)


func get_database_version(db_path: String):
	var db = _SQLite.new()
	db.path = db_path
	db.open_db()
	db.query("SELECT value FROM constants WHERE name = 'database_version'")
	db.close_db()
	print(ProjectSettings.globalize_path(db.path), db.query_result)
	print(Utils.file_exists(db.path))
	var version = db.query_result[0].value
	if version:
		return version
	else:
		push_error("Database version for db %s not found" % db_path)
