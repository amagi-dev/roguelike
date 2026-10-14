extends Node2D

class_name TurnManager

var actors: Array[Actor] = []
var current: Actor = null

func _ready() -> void:
	for actor in get_children():
		actor.signal_next_actor.connect(signal_next_active)
		actors.append(actor)
	pass

	current = actors[0]
	current.active()
pass

func signal_next_active() -> void:
	if current == null:
		return

	current.passive();

	# switch to next actor
	var current_index = actors.find(current)
	var next_index = (current_index + 1) % actors.size()
	current = actors[next_index]

	current.active();
pass






func _process(_delta: float) -> void:
	pass
