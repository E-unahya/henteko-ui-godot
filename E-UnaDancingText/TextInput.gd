extends MeshInstance3D

@export_multiline var message : String
@export var debug : bool
var text_array : Array

# 全てのテキストを出し切った時に出すシグナル
signal all_text_shutsuryoku_zumi(message:String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_array = mesh.text.split()
	if message != "":
		text_array = message.split()
	mesh.text = ""


func _input(event: InputEvent) -> void:
	# TODO マルチラインっぽくするために改行をしたい
	var row = 0
	var reset = 0
	if event.is_action_pressed("LeftMouse"):
		for t in range(len(text_array)):
			await get_tree().create_timer(0.1).timeout
			if text_array[t] == "\n":
				row -= 1
				reset = t + 1
			# スペースがすごいのぉ・・・
			var rigid_text : RigidText = preload("res://E-UnaDancingText/RigidText.tscn").instantiate()
			rigid_text.set_char(text_array[t])
			rigid_text.position = Vector3(t - reset, row, 0)
			add_child(rigid_text)
			if debug:
				rigid_text.set_timer(false)
		all_text_shutsuryoku_zumi.emit(message)
