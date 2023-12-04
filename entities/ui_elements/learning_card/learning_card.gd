extends Control

"""Card swipe mechanism: change rotation degree while card is
moving. If card x_offset above some threshold, card count as swiped"""

var threshold: int

var flipped = false

func _ready():
	pass


func _on_Panel_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		flip()


func flip():
	if flipped:
		return
	
	$"%AnimationPlayer".play("flip")
	flipped = true
