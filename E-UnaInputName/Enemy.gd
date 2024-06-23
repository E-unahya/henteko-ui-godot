extends Area2D

const SPEED = 200

func _ready():
	pass # Replace with function body.

func _process(delta):
	# よくいる敵のように床を行き来するような奴にしたい。
	position.x += SPEED * delta
