extends ScrollContainer

func add_item(item: Node):
	$"%VBoxContainer".add_child(item)

func clear():
	Utils.queue_free_children($"%VBoxContainer")
