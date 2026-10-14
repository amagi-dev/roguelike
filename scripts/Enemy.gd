class_name Enemy
extends Actor

# INFO: ready
func _ready() -> void:

	# init positoin for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

pass

func action() -> void:

	if is_current_active == false:
		return;
	pass

	if(is_current_active == true):

		# move_direction = Vector2i(0,0)
		move_direction = Vector2i(0,1)

		is_current_active = false;


		# get current move direction from input
		var c = map.get_cell_from_position(global_position);
		var target_cell = c + move_direction;
		var pos = map.get_position_from_cell(target_cell);

		# reset move direction
		move_direction = Vector2i.ZERO

		# moveing in tween
		var tween = create_tween()
		tween.tween_property(self,"global_position",pos,0.15).set_trans(Tween.TRANS_SINE);
		tween.play()

		# if turn next
		if(next_actor() == true):
			is_current_active = true;
		pass
	pass
pass




func _process(_delta: float) -> void:
	pass
