extends Actor
class_name PlayerController


# INFO: ready
func _ready() -> void:

	# init positoin for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

pass

# INFO: update



func update() -> void:

	# action process
	if(move_direction != Vector2i.ZERO):

		# get current move direction from input
		var c = map.get_cell_from_position(global_position);
		var target_cell = c + move_direction;
		var pos = map.get_position_from_cell(target_cell);

		if(true):

			move_direction = Vector2i.ZERO
			is_current_active = false;

			# moveing in tween
			var tween = create_tween()
			tween.tween_property(self,"global_position",pos,0.15).set_trans(Tween.TRANS_SINE);
			tween.play()

			# reset move direction
			move_direction = Vector2i.ZERO

			if(next_actor() == true):
				is_current_active = true;
			pass
		pass
	pass
pass

func _process(_delta: float) -> void:

	# ESC to quit ## Debug only
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	pass

	# check if my turn
	if is_current_active == false:
		return;

	if Input.is_action_just_pressed("arrow_up"):
		move_direction = Vector2i(0,-1)
	elif Input.is_action_just_pressed("arrow_down"):
		move_direction = Vector2i(0,1)
	elif Input.is_action_just_pressed("arrow_left"):
		move_direction = Vector2i(-1,0)
	elif Input.is_action_just_pressed("arrow_right"):
		move_direction = Vector2i(1,0)
	pass

pass
