extends Node3D
@onready var line_edit: LineEdit = $LineEdit
@onready var se: AudioStreamPlayer = $SE
@export var honban : bool = false

var seikai : String

func _ready() -> void:
	line_edit.hide()
	$DamageColor/AnimationPlayer.play("RESET")
	# 本番をオンにするとコンフィグファイルから適当な物を仕入れて取り出して云々しちゃう


func _on_area_3d_body_entered(body: Node3D) -> void:
	$DamageColor/AnimationPlayer.play("Damage")


func _on_text_input_all_text_shutsuryoku_zumi(message:String) -> void:
	seikai = message
	line_edit.show()


func _on_line_edit_text_submitted(new_text: String) -> void:
	if seikai == new_text:
		# ここの変をいじってゲームの形に持っていきたいと考えております。
		se.stream = load("res://E-UnaDancingText/SE/クイズ正解1.mp3")
		$DamageColor/AnimationPlayer.play("Seikai")
	else:
		se.stream = load("res://E-UnaDancingText/SE/クイズ不正解1.mp3")
		$DamageColor/AnimationPlayer.play("Damage")
	# 正解しても不正解でももう一度チャレンジできるようにやり直したい
	se.play()
