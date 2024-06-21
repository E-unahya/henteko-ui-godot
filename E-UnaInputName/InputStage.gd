extends Node2D
@onready var goju_on = $GojuOn


# Called when the node enters the scene tree for the first time.
func _ready():
	for g in goju_on.get_children():
		for c in g.get_children():
			# キャラクターが入ったときの処理
			c.body_entered.connect(c._on_body_area_entered)
