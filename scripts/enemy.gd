extends Actor
class_name Enemy


# INFO: ready
func _ready() -> void:

	# init positoin for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

	type = Actor.Type.ENEMY;
	state = State.QUIT;
pass

func idle() -> void:

	var move = [Vector2i(0,-1),Vector2i(0,1),Vector2i(-1,0),Vector2i(1,0)].pick_random();

	move_direction = move;

	state = State.ACTION
pass

func action() -> void:

	state = State.EXECUTE;
pass



func execute() -> void:


	state = State.CURRENT_EXECUTE;
	var tween = create_tween()

	tween.tween_interval(0.1);
	# tween = tween_move(tween);
	tween.chain().finished.connect(func():
		next_turn();
	);

	tween.play(); # play tween
pass
