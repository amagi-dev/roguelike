class_name PlayerController
extends Actor

func _ready() -> void:

	# init positoin for layer
	var cell = get_cell_from_position(global_position);
	global_position = get_position_from_cell(cell);
pass


func _process(_delta: float) -> void:

	# ESC to quit ## Debug only
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	pass

	# check if my turn
	if isActive == false:
		return;



	if Input.is_action_just_pressed("arrow_up"):
		move_direction = Vector2i(0,-1)
		isMoving = true;
	elif Input.is_action_just_pressed("arrow_down"):
		move_direction = Vector2i(0,1)
		isMoving = true;
	elif Input.is_action_just_pressed("arrow_left"):
		move_direction = Vector2i(-1,0)
		isMoving = true;
	elif Input.is_action_just_pressed("arrow_right"):
		move_direction = Vector2i(1,0)
		isMoving = true;
	pass

	if (isMoving == true):

		print("Player: isMoving	",isMoving)


		# get current move direction from input
		var c = get_cell_from_position(global_position);
		var target_cell = c + move_direction;
		var pos = get_position_from_cell(target_cell);

		# reset move direction adn set isMoving to true
		move_direction = Vector2i.ZERO
		isMoving = false;

		# moveing in tween
		var tween = create_tween()
		tween.tween_property(self,"global_position",pos,0.15).set_trans(Tween.TRANS_SINE);
		tween.finished.connect(event_finished);
		await tween.finished;


		signal_turn_finished.emit()	# turn end
	pass
pass
