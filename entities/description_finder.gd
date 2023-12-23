extends Node

const LanguageCodes = {
	"Russian": "ru",
	"English": "en",
}

var client := SimpleHTTPClient.new()
var url := "https://api.dictionaryapi.dev/api/v2/entries/en/%s"

signal description_found(descriptions)

func find_description(query: String):
	if client.requesting:
		return
	
	var response: HTTPResponse = yield(
		client.request_async(
			url % query,
			{},
			true,
			HTTPClient.METHOD_GET),
			"completed"
			)
	if response.successful():
		var result = parse_json(response.body.get_string_from_utf8())
		result = result[0]["meanings"][0]["definitions"][0]["definition"]
		if result:
			emit_signal("description_found", result)
