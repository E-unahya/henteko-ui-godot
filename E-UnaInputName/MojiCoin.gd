extends Area2D

class_name MojiCoin
@export_file("*.tres") var texture_path : String
var input_char : String

func _ready():
	if texture_path != null:
		var texture = load(texture_path)
		input_char = texture.resource_name
		$Sprite2D.texture = load(texture_path)


func get_texture_meta() -> String:
	return input_char

func _on_body_area_entered(body:PhysicsBody2D):
	# 文字情報を取得してなんかやる処理を配信で行う。
	print(get_texture_meta())
