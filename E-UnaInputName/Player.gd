extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $Animation
@onready var collision_shape_2d : CollisionShape2D = $CollisionShape2D
@onready var label = $Label

const SPEED = 150
const JUMP_VELOCITY = -200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var oneway_layer = 3
# 梯子エリアに入っているから、上のぼれるよ！
var hasigo_area_entered : bool
# 決定ボタン
var kettei : bool
# 名前を決定するかもしれないシグナル
signal kononamae
# 自決用のシグナル
signal harakiri

func _ready():
	hasigo_area_entered = false
	animation.play("Idle")
	label.hide()

func _physics_process(delta):
	if not is_on_floor() and not hasigo_area_entered:
		velocity.y += (gravity * delta) / 2

	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or hasigo_area_entered:
			velocity.y = JUMP_VELOCITY

	if Input.get_axis("ui_up", "ui_down") and hasigo_area_entered:
		velocity.y = Input.get_axis("ui_up", "ui_down") * SPEED

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _input(event):
	if event.is_action_pressed("ui_left"):
		animation.flip_h = false
	if event.is_action_pressed("ui_right"):
		animation.flip_h = true
	if event.is_action_pressed("Harakiri"):
		harakiri.emit()
	if event.is_action_pressed("ui_accept") and kettei:
		kononamae.emit()

func _on_hasigo_area_body_entered(body):
	if body.name == "Player":
		collision_mask = 2
		hasigo_area_entered = true

func _on_hasigo_area_body_exited(body):
	if body.name == "Player":
		collision_mask = 1
		hasigo_area_entered = false

func _on_door_area_body_entered(body):
	if body.name == "Player":
		label.show()
		kettei = true

func _on_door_area_body_exited(body):
	if body.name == "Player":
		label.hide()
		kettei = false

func _seppuku():
	harakiri.emit()
