extends Node

func generate_random_words(amount: int, category_id = null):
	return DatabaseManager.get_random_words(amount, category_id)
	
	
