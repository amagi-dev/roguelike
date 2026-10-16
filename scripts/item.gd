extends Actor
class_name Item




@export var icon:PackedScene;








# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# init positoin for layer
	var cell = map.get_cell_from_position(global_position);
	global_position = map.get_position_from_cell(cell);

	type = Actor.Type.ITEM;
	state = State.QUIT;

pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
