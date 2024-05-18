extends Control
@onready var ball: RigidBody2D = $HBoxContainer/TougleButton/Ball
@onready var tougle_button: TextureButton = $HBoxContainer/TougleButton

signal checked

func _on_tougle_button_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_tween_finished)
	tween.tween_property(ball, "position", Vector2(99, 18), 1.0).set_trans(Tween.TRANS_CUBIC)

func _on_tween_finished():
	ball.freeze = false
	ball.apply_central_impulse(Vector2(1000, 0))
	tougle_button.release_focus()
	checked.emit()
