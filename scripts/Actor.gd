class_name Actor
extends Area2D

@export var map: TileMapLayer;


@export var turn_manager: TurnManager

var move_direction: Vector2i = Vector2i.ZERO;	# current move direction
var is_current_active: bool = false;			# if current turn is turn
var is_turn: bool = false;						# current active_turn or not



var turn_point: int = 2;


# Check



# Signal
signal signal_next_actor
signal signal_active;
signal signal_passive;


# INFO: ready
func _ready() -> void:

	# init position for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

	signal_passive.connect(passive);
	signal_active.connect(active);
pass

func next_actor() -> bool:

	turn_point -= 1;

	if(turn_point <= 0):

		is_current_active = false;	# reset turn

		turn_point = 2; 			# reset turn point
		signal_next_actor.emit()	# next turn signal

		return false;
	pass

	return true;
pass

func active() -> void:
	is_current_active = true;
pass

func passive() -> void:
	is_current_active = false;
pass

# Get cell
func get_cell() -> Vector2i:
	return map.get_cell_from_position(global_position)
pass
