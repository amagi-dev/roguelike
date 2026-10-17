extends Sprite2D

class_name Effect;

var sprite:Sprite2D = null;

var tween:Tween = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = create_tween();
pass

func finished() -> void:
	queue_free();
pass

func play() -> void:
	tween.set_loops(2);
	tween.tween_property(self,"modulate:a",0.1,0.02);
	tween.chain().tween_property(self,"modulate:a",0.8,0.02);
	tween.finished.connect(finished);
	tween.play();
pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
