extends HBoxContainer

var id

signal selected(id)


#TODO: replace with constructor
func set_label_text(label_text: String):
	$"%WordButton".text = label_text


func set_id(_id: int):
	id = _id


func _on_ListItem_pressed():
	emit_signal("selected", id)


func _on_DeleteButton_pressed():
	DatabaseManager.delete_word(id)
