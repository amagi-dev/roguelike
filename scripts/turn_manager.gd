extends Node2D

class_name TurnManager

var actors: Array[Actor] = []
var current: Actor = null

func _ready() -> void:
	for actor in get_children():
		if(actor.type == Actor.Type.ITEM):
			continue

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

func get_entity_from_cell(cell) -> Actor:

	for actor in get_children():
		if(cell == actor.get_cell()):
			return actor
		pass
	pass

	return null
pass

func set_delete(object:Actor) -> void:

	for actor in actors:
		if(object == actor):
			actors.erase(object)  # 配列からこのオブジェクトを削除
		pass
	pass
pass


func _process(_delta: float) -> void:
	pass
