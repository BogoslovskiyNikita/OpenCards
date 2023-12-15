extends Panel

enum Modes {WORDS_LEARNED, WORDS_TO_LEARN}

const TextTemplate = {
	Modes.WORDS_LEARNED: "%d words\nknown",
	Modes.WORDS_TO_LEARN: "%d words\nto learn" 
}

var mode

func _ready():
	match get_name():
		"LearnedStatsWidget":
			init(Modes.WORDS_LEARNED)
		"ToLearnStatsWidget":
			init(Modes.WORDS_TO_LEARN)
	

func init(_mode: int):
	mode = _mode
	
	var style: StyleBoxFlat = load("res://entities/ui_elements/stats_widget/styleboxflat.tres")
	style = style.duplicate()
	
	var words_count: int
	
	match mode:
		Modes.WORDS_LEARNED:
			words_count = DatabaseManager.count_learned_words()
			style.bg_color = "#46755d"
		Modes.WORDS_TO_LEARN:
			words_count = DatabaseManager.count_words_to_learn()
			style.bg_color = "#b0ad74"
	
	add_stylebox_override("panel", style)
	
	$"%Label".text = TextTemplate[mode] % words_count
	
