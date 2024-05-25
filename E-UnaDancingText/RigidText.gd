extends RigidBody3D

class_name RigidText
@onready var text_mesh: MeshInstance3D = $TextMesh
@onready var timer: Timer = $Timer
@export var rand_min : float = -10
@export var rand_max : float = 10

var char : String
# タイマーの設定の
var auto_start : bool = true

func _ready() -> void:
	# こちらにテキストメッシュの設定を行う
	# 事前に行うことで何とかなる
	freeze = true
	text_mesh.mesh = TextMesh.new()
	text_mesh.mesh.horizontal_alignment = 0
	text_mesh.mesh.vertical_alignment = 0
	text_mesh.mesh.font_size = 18
	text_mesh.mesh.pixel_size = 0.05
	text_mesh.mesh.material = load("res://E-UnaDancingText/TextColorMaterial.tres")
	# フォント関係はもう少し考える必要あるかも
	text_mesh.mesh.font = load("res://E-UnaDancingText/Rock_3D/Rock3D-Regular.ttf")
	text_mesh.mesh.text = char
	timer.autostart = auto_start

func set_char(arg_char:String) -> void:
	char = arg_char

func set_timer(boolean : bool):
	auto_start = boolean

func _on_timer_timeout() -> void:
	# 一個一個自我を持ってはじける感じにしたい。
	freeze = false
	randomize()
	apply_impulse(
		Vector3(randf_range(rand_min, rand_max),randf_range(rand_min, rand_max),randf_range(rand_min, rand_max)),
		Vector3(randf_range(rand_min,rand_max),randf_range(rand_min, rand_max),randf_range(rand_min, rand_max),))
	await get_tree().create_timer(0.2).timeout
	apply_impulse(
		Vector3(randf_range(-rand_min, -rand_max),randf_range(-rand_min, -rand_max),randf_range(-rand_min, -rand_max)),
		Vector3(randf_range(-rand_min,-rand_max),randf_range(-rand_min, -rand_max),randf_range(-rand_min, -rand_max)))
