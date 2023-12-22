extends Node

const LanguageCodes = {
	"Russian": "ru",
	"English": "en",
}

var client := SimpleHTTPClient.new()
var url := "https://translate.terraprint.co/translate"
var headers = { "Content-Type": "application/json" }

var source_language: String
var target_language: String

signal translation_completed(translation)


func get_language_settings():
	source_language = LanguageCodes[Settings.get_language_to_learn()]
	target_language = LanguageCodes[Settings.get_native_language()]


func _ready():
	get_language_settings()
	Settings.connect("settings_changed", self, "get_language_settings")


func translate(query: String):
	if client.requesting:
		return
	
	var body = {
		"q": query,
		"source": source_language,
		"target": target_language,
		"format": "text"
	}
	var response: HTTPResponse = yield(
		client.request_async(
			url,
			headers,
			true,
			HTTPClient.METHOD_POST,
			JSON.print(body).to_utf8()),
			"completed"
			)
	if response.successful():
		var result = parse_json(response.body.get_string_from_utf8())["translatedText"]
		emit_signal("translation_completed", result)
