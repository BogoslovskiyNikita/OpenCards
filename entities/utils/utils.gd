extends Node

func queue_free_children(node: Node):
	for child in node.get_children():
		child.queue_free()


# Checks if two lists have the same elements regardless of their order.
func are_lists_equal(list1: Array, list2: Array) -> bool:
	if list1.size() != list2.size():
		return false

	var copy1 = list1.duplicate()
	var copy2 = list2.duplicate()

	copy1.sort()
	copy2.sort()

	return copy1 == copy2
