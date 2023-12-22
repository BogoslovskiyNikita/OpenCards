extends Node

## TODO: var -> const
var user_config_file_path = "user://data/settings.cfg"
var app_launched_for_first_time = !file_exists(user_config_file_path) or cfg_contains_null_value() or !cfg_structure_are_the_same()

signal settings_changed

func _ready():
	if app_launched_for_first_time:
		process_init_default_cfg()


## Check if we need to create new settings.cfg file
func process_init_default_cfg():
	if app_launched_for_first_time:
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
	emit_signal("settings_changed")


func _get_cfg_value(section: String, key: String):
	var config_file = ConfigFile.new()
	config_file.load(user_config_file_path)
	return config_file.get_value(section, key)


func get_native_language():
	return _get_cfg_value("language", "native_language")


func get_language_to_learn():
	return _get_cfg_value("language", "language_to_learn")


## Return true if user's settings.cfg file has same structure with default
## If we update default settings, user will be asked to fill settings again.
func cfg_structure_are_the_same() -> bool:
	if !file_exists(user_config_file_path):
		return true
	
	var config_file = ConfigFile.new()
	config_file.load(user_config_file_path)
	
	var user_cfg_sections = config_file.get_sections()
	var default_sections = ["language"]
	
	var user_cfg_values = Dictionary()
	for section in user_cfg_sections:
		user_cfg_values[section] = config_file.get_section_keys(section)
	
	var default_values = {
		"language": PoolStringArray([
			"ui_language",
			"native_language",
			"language_to_learn"
			])
	}
	
	if !Utils.are_lists_equal(default_sections, user_cfg_sections):
		return false
	
	## Note: "==" operator compare dict by references
	if !Utils.compare_dictionaries(default_values, user_cfg_values):
		return false

	return true


func cfg_contains_null_value() -> bool:
	if !file_exists(user_config_file_path):
		return true
	
	var config_file = ConfigFile.new()
	config_file.load(user_config_file_path)

	if config_file.get_sections().empty():
		return true
	
	for section in config_file.get_sections():
		for key in config_file.get_section_keys(section):
			var value = config_file.get_value(section, key)
			if value == "" or value == "none" or value == "null":
				return true
	
	return false
