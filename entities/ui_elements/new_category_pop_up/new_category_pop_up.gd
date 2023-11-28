extends Panel

func open():
	show()


func close():
	hide()


func _on_AddButton_pressed():
	DatabaseManager.add_category($"%CategoryNameLineEdit".text)
	## TODO: Check for DB errors and uniques category name here.
	hide()
