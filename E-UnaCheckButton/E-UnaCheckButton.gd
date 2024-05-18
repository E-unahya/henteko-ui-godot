extends Control
@onready var accept_mark: Sprite2D = $AcceptMark
@onready var mouse_pointer: Sprite2D = $MousePointer

# 動かすためのムーブフラグ
var move_flag : bool

# 真・◇)ゞ
signal accept

func _ready() -> void:
	move_flag = false
	$AcceptMark/AcceptMarkArea.disable_mode = true
	$AcceptMark/AcceptMarkArea/CollisionShape2D.disabled = true
	$GoalArea.disable_mode = true
	$MousePointer/MouseArea.disable_mode = true
	randomize()
	accept_mark.hide()
	mouse_pointer.hide()
	$ButtonContainer/Label.hide()

func _process(delta: float) -> void:
	mouse_pointer.position = get_local_mouse_position()
	if move_flag:
		accept_mark.position = mouse_pointer.position

func _on_texture_button_pressed() -> void:
	randomize()
	mouse_pointer.show()
	if accept_mark.visible:
		accept_mark.hide()
	else:
		accept_mark.show()
	accept_moving()
	$ButtonContainer/Label.show()

func accept_moving() -> void:
	var rand_pos =  Vector2(randf_range(-680, 680), randf_range(-680, 680))
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_accept_moving_tween_finished)
	tween.tween_property(accept_mark, "position", rand_pos, 0.5).set_trans(Tween.TRANS_CUBIC)

func _on_accept_moving_tween_finished() -> void:
	$AcceptMark/AcceptMarkArea.disable_mode = false
	$AcceptMark/AcceptMarkArea/CollisionShape2D.disabled = false
	$GoalArea.disable_mode = false
	$MousePointer/MouseArea.disable_mode = false

func _on_accept_mark_area_area_entered(area: Area2D) -> void:
	match area.name:
		"MouseArea":
			move_flag = true
		"GoalArea":
			move_flag = false
			accept_mark.position = $GoalArea/CollisionShape2D.position

func _on_goal_area_area_entered(area: Area2D) -> void:
	if area.name == "AcceptMarkArea":
		$ButtonContainer/Label.text = "同意しました。"
		$AcceptMark/AcceptMarkArea/CollisionShape2D.disabled = true
		accept.emit()
