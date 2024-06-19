extends Area2D

class_name MojiCoin
@export_file("*.tres") var texture_path : String

func _ready():
	if texture_path != null:
		$Sprite2D.texture = load(texture_path)


func get_texture_meta():
	return $Sprite2D.texture.get_meta("InputChar", "null")
