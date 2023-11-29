extends Control

func setup(category_id: int):
	print(DatabaseManager.get_category(category_id))
