extends Actor
class_name PlayerController


# INFO: ready
func _ready() -> void:

	# init positoin for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

	state = State.IDLE;
pass

# INFO: update


func action() -> void:
	state = State.EXECUTE;
pass

func effect_exited() -> void:
	next_turn();
pass

func execute() -> void:


	if (check_map_wall_from_direction() == false) && (check_entity_from_direction() == null):
		var tween = create_tween()
		state = State.CURRENT_EXECUTE;

		tween = tween_move(tween);
		tween_finished(tween,
		func():
			next_turn();
		);

		tween.play(); # play tween
	elif(check_map_wall_from_direction() == false) && (check_entity_from_direction() != null):

		# collision with entity
		var entity = check_entity_from_direction();

		match entity.type:
			Actor.Type.ITEM:
				state = State.CURRENT_EXECUTE;

				interfaces.set_item(entity.icon);
				entity.queue_free();

				var tween = create_tween();
				tween = tween_move(tween);
				tween_finished(tween,
				func():
					next_turn();
				);

				tween.play(); # play tween
			pass

			Actor.Type.ENEMY:
				state = State.CURRENT_EXECUTE;
				entity.take_damage();

				var e = damage.instantiate();
				add_child(e);
				e.global_position = entity.global_position;
				e.tree_exited.connect(effect_exited);
				e.play();
			pass
		pass
	else:
		state = State.IDLE;
	pass
pass

func idle() -> void:
	if Input.is_action_pressed("arrow_up"):
		move_direction = Vector2i(0,-1)
		state = State.ACTION;

	elif Input.is_action_pressed("arrow_down"):
		move_direction = Vector2i(0,1)
		state = State.ACTION;

	elif Input.is_action_pressed("arrow_left"):
		move_direction = Vector2i(-1,0)
		state = State.ACTION;

	elif Input.is_action_pressed("arrow_right"):
		move_direction = Vector2i(1,0)
		state = State.ACTION;
	pass
pass
