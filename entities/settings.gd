extends Node

## TODO: var -> const
var user_config_file_path = "user://data/settings.cfg"

func _ready():
	if !file_exists(user_config_file_path):
		init_default_cfg()
	if !cfg_structure_are_the_same():
		init_default_cfg()


func file_exists(file_path: String) -> bool:
	var file = File.new()
	
	if file.file_exists(file_path):
		return true
	else:
		return false


func init_default_cfg():
	var config_file = ConfigFile.new()
	
	config_file.set_value("language", "ui_language", "none")
	config_file.set_value("language", "native_language", "none")
	config_file.set_value("language", "language_to_learn", "none")
	
	config_file.save(user_config_file_path)


func set_ui_language(language: String):
	_set_cfg_value("language", "ui_language", language)


func set_native_language(native_language: String):
	_set_cfg_value("language", "native_language", native_language)


func set_language_to_learn(language_to_learn: String):
	_set_cfg_value("language", "language_to_learn", language_to_learn)


func _set_cfg_value(section: String, key: String, value: String):
	var config_file = ConfigFile.new()
	config_file.load(user_config_file_path)
	config_file.set_value(section, key, value)
	config_file.save(user_config_file_path)


func _get_cfg_value(section: String, key: String):
	var config_file = ConfigFile.new()
	config_file.load(user_config_file_path)
	return config_file.get_value(section, key)


func get_native_language():
	return _get_cfg_value("language", "native_language")


func get_language_to_learn():
	return _get_cfg_value("language", "language_to_learn")


## TODO: fill body of this method
func cfg_structure_are_the_same() -> bool:
	return true


## TODO: fill body of this method
func cfg_contains_null_value() -> bool:
	return false


