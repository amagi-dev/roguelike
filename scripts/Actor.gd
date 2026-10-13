class_name Actor
extends Area2D

@export var map: TileMapLayer

var move_direction: Vector2i = Vector2i.ZERO;	# current move direction
var isMoving: bool = false;						# current moveing or not

var isActive: bool = false;						# current turn active or not
signal signal_turn_finished;					# signal for turn finished
signal signal_next_turn;						# signal for next turn


func _ready() -> void:
	signal_turn_finished.connect(event_finished)



	# init positoin for layer
	var cell = get_cell_from_position(global_position);
	global_position = get_position_from_cell(cell);

pass

func event_finished() -> void:

	move_direction = Vector2i.ZERO
	isMoving = false;
	isActive = false;

	signal_next_turn.emit() # next actor turn
pass



# Get global_position from cell
func get_position_from_cell(cell: Vector2i) -> Vector2:
	var local = map.map_to_local(cell)
	var global = map.to_global(local)

	return global
pass


# Get cell from global_position
func get_cell_from_position(global: Vector2) -> Vector2i:
	var local = map.to_local(global)
	var cell = map.local_to_map(local)

	return cell
pass
