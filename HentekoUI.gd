extends Node2D
@onready var game_start_button: Button = $GameStartButton
@onready var tougle_button_accept: Button = $TougleButtonAccept


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_start_button.hide()
	tougle_button_accept.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_e_una_check_button_2_accept() -> void:
	game_start_button.show()

func _on_tougle_checked() -> void:
	tougle_button_accept.show()
