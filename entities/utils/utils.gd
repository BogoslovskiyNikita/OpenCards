extends Node

func queue_free_children(node: Node):
	for child in node.get_children():
		child.queue_free()
