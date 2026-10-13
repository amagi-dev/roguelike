class_name Enemy
extends Actor


func _ready() -> void:

	# init positoin for layer
	var cell = get_cell_from_position(global_position);
	global_position = get_position_from_cell(cell);
pass


func _process(_delta: float) -> void:

	if isActive == false:
		return;


	move_direction = Vector2i(0,1)
	isMoving = true;

	if(isMoving == true):

		print("Enemy: isMoving	",isMoving)

		#
		# var delay = create_tween()
		# delay.tween_interval(0.7)
		# await delay.finished;

		await get_tree().create_timer(0.7).timeout

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

		print("Enemy: end")
		signal_turn_finished.emit() # turn end
	pass
pass
