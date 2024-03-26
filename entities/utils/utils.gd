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


# Compare the content of two dictionaries.
# Returns true if the dictionaries have the same keys and values, false otherwise.
func compare_dictionaries(dict1: Dictionary, dict2: Dictionary) -> bool:
	return dict1.hash() == dict2.hash()


# Returns ture if a file exists at the specified path, false otherwise.
func file_exists(file_path: String) -> bool:
	var file = File.new()
	var result = file.open(file_path, File.READ)
	if result == OK:
		file.close()
		return true
	return false
