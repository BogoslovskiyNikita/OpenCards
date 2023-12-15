extends Node

func generate_random_words(amount: int, category_id = null):
	return DatabaseManager.get_random_words(amount, category_id)


func on_word_learned(word_id: int):
	DatabaseManager.increase_correct_answers_count(word_id)

