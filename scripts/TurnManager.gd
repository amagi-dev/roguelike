extends Node2D

@export var map: TileMapLayer

var actors: Array[Actor] = []
var current: Actor = null

func _ready() -> void:
	for actor in get_children():
		actors.append(actor)
		actor.signal_next_turn.connect(turn_ended) # next turn signal

		# begin with first actor
		current = actors[0]
		current.isActive = true
pass

func turn_ended() -> void:
	if current == null:
		return

	# next index and next actor
	var current_index = actors.find(current)
	var next_index = (current_index + 1) % actors.size()
	current = actors[next_index]

	current.isActive = true # next turn enable

	print("Next turn:	", current.name)
pass


func _process(_delta: float) -> void:
	pass
