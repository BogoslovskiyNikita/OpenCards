extends Button

var id

signal selected(id)

#TODO: replace with constructor
func set_label_text(label_text: String):
	text = label_text


func set_id(_id: int):
	id = _id


func _on_ListItem_pressed():
	emit_signal("selected", id)
