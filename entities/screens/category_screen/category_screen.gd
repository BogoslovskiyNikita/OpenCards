extends Control

func setup(category_id: int):
	var category = DatabaseManager.get_category(category_id)
	$"%CategoryInfo".text = "Category: %s, %d words" % [category.category_name, DatabaseManager.get_words_count(category_id)]

