extends Control




var items:Array[Item] = [];
var item_manager = null;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	item_manager = get_node("ItemManager") as GridContainer;

pass # Replace with function body.

func set_item(icon:PackedScene) -> void:

	var item = icon.instantiate();
	item_manager.add_child(item);
	# items.append(item);

pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
