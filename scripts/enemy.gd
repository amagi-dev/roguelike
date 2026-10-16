extends Actor
class_name Enemy


# INFO: ready
func _ready() -> void:

	# init positoin for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

	state = State.QUIT;
pass

func idle() -> void:

	# var move = [Vector2i(0,-1),Vector2i(0,1),Vector2i(-1,0),Vector2i(1,0)].pick_random();

	move_direction = Vector2i.ZERO;
	# move_direction = move;

	state = State.ACTION
pass

func action() -> void:

	state = State.EXECUTE;
pass



func execute() -> void:


	state = State.CURRENT_EXECUTE;
	var tween = create_tween()
	tween.tween_interval(0.3);
	tween.finished.connect(func():
		next_turn();
	);

	tween.play(); # play tween

	#
	# if (check_map_wall_from_direction() == false) && (check_entity_from_direction() == null):
	# 	var tween = create_tween()
	# 	state = State.CURRENT_EXECUTE;
	#
	# 	# var pos = get_position_move_direction();
	#
	# 	tween.tween_interval(0.3);
	# 	# tween.chain().tween_property(self,"global_position",pos,0.30).set_trans(Tween.TRANS_SINE);
	# 	tween.finished.connect(func():
	# 		next_turn();
	# 	);
	#
	# 	tween.play(); # play tween
	#
	# else:
	# 	state = State.IDLE;
	# pass
	#
pass
