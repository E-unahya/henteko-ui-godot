extends RigidBody2D

func _ready() -> void:
	position = Vector2(30, 18)
	freeze = true

func _process(delta: float) -> void:
	if freeze:
		position = Vector2(30, 18)
		set_linear_velocity(Vector2.ZERO)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(30, 18), 1.0).set_trans(Tween.TRANS_CUBIC)
	tween.finished.connect(_on_tween_finished)
	transform.origin = Vector2.ZERO

func _on_tween_finished():
	freeze = true
