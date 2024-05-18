extends StaticBody2D
@onready var floor: StaticBody2D = self
@onready var bgm: AudioStreamPlayer = $BGM
@onready var bar: RigidBody2D = $Bar

var rotation_flag : bool

func _ready() -> void:
	rotation_flag = false

func _process(delta: float) -> void:
	if rotation_flag:
		floor.rotation += get_global_mouse_position().y * 0.0001
	bgm.volume_db = bar.position.x

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouse"):
		bar.freeze = false
		rotation_flag = true
	if event.is_action_released("LeftMouse"):
		rotation_flag = false
		bar.freeze = true

