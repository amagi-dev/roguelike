class_name Actor
extends Area2D

@export var map: TileMapLayer;
@export var turn_manager: TurnManager;
@export var interfaces: Control;

var move_direction: Vector2i = Vector2i.ZERO;	# current move direction
var is_current_active: bool = false;			# if current turn is turn
var is_turn: bool = false;						# current active_turn or not

var type = Type.NONE;

var turn_point: int = 2;


# Check



# Signal
signal signal_next_actor
signal signal_active;
signal signal_passive;


# state machine
enum State {
	IDLE,				# key input or intelligence
	WAIT,				# freeze state

	ACTION,				# action confirm
	EXECUTE,			# execute action
	CURRENT_EXECUTE,	# current execute

	EXIT_TURN,			# exit turn

	QUIT,				# quit current actor
	}

enum Type {
	PLAYER,
	ENEMY,
	ITEM,

	NONE,
	}





var state:State

# INFO: ready
func _ready() -> void:

	# init position for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

	signal_passive.connect(passive);
	signal_active.connect(active);
pass

func next_turn() -> void:

	move_direction = Vector2i.ZERO;

	turn_point -= 1;

	if(turn_point <= 0):
		state = State.QUIT;			# actor end
		turn_point = 2; 			# reset turn point
		signal_next_actor.emit()	# next turn signal

		return;
	pass


	state = State.IDLE; # next turn

pass

func active() -> void:
	state = State.IDLE;
pass

func passive() -> void:
	state = State.QUIT;
pass

# Get cell
func get_cell() -> Vector2i:
	return map.get_cell_from_position(global_position)
pass

func control() -> void:
	pass

# check wall from map
func check_map_wall_from_direction() -> bool:

	# hit tilemap check
	var info = map.get_info_from_cell(self,move_direction);

	if(info["exists"] == true):
		if(info["is_wall"]):
			return true;
		pass
	pass

	return false;
pass

# check entity from actors
func check_entity_from_direction() -> Actor:

	# hit entity check
	var target_cell = map.get_cell_from_position(global_position) + move_direction;
	var entity = turn_manager.get_entity_from_cell(target_cell);

	return entity as Actor;
pass



# INFO:======================================================================
# = Helpers
# ===========================================================================

# destination to position
func get_position_move_direction() -> Vector2:
	var c = map.get_cell_from_position(global_position);
	var target_cell = c + move_direction;
	var pos = map.get_position_from_cell(target_cell);

	return pos;
pass



# INFO: Tween process

## move
func tween_move(tween) -> Tween:

	var dest = get_position_move_direction();

	tween.tween_property(self,"global_position",dest,0.30).set_trans(Tween.TRANS_SINE);
	return tween.chain();
pass


func tween_delay(tween,time) -> Tween:
	return tween.tween_interval(time).chain()
pass

# attack
## NOTE: debug only
func tween_attack(tween) -> Tween:

	var original_pos = global_position;

	# get current move direction from input
	var c = map.get_cell_from_position(global_position);
	var pos = map.get_position_from_cell(c);

	# half map size
	var size:Vector2i = Vector2i(Vector2(map.tile_set.tile_size) / float(2));
	pos = pos + Vector2(size * move_direction);

	tween.tween_property(self,"global_position",pos,0.25).set_trans(Tween.TRANS_SINE);
	tween.chain().tween_property(self,"global_position",original_pos,0.25).set_trans(Tween.TRANS_SINE);

	return tween.chain();
pass


# finished signal
func tween_finished(tween,callback: Callable) -> Tween:
	tween.finished.connect(callback);
	return tween.chain();
pass


func finished_move() -> void:
	next_turn();
pass



# INFO: base function

# idle state
func idle() -> void:
	pass

func action() -> void:
	pass

func execute() -> void:
	pass




# INFO:======================================================================
# = Action
# ===========================================================================







func _process(_delta: float) -> void:

	# ESC to quit ## Debug only
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	pass

	match state:
		State.IDLE: # input key ofr enemy
			idle()

		State.WAIT: # NOTE: not used
			pass

		State.ACTION: # select action process
			action()

		State.EXECUTE: # execute action process
			execute()
			pass

		State.CURRENT_EXECUTE: # No process
			pass

		State.EXIT_TURN:
			pass

		State.QUIT:
			return;
	pass
pass
