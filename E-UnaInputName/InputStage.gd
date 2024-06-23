extends Node2D
@onready var goju_on = $GojuOn
@onready var press_rto_restart = $Control/PressRtoRestart
@onready var hasigo_area = $HasigoArea
@onready var player = $Player
@onready var is_this_name = $Control/IsThisName
@onready var name_label = $Control/NameLabel

var name_string : String


func _ready():
	is_this_name.hide()
	name_label.hide()
	name_string = ""
	for g in goju_on.get_children():
		for c in g.get_children():
			# キャラクターが入ったときの処理
			c.body_entered.connect(c._on_body_area_entered)
			c.moji_in.connect(on_moji_in)
	press_rto_restart.hide()

func _input(event):
	if press_rto_restart.visible and event.is_action_pressed("Restart"):
		get_tree().reload_current_scene()
	if name_label.visible:
		if event.is_action_pressed("ui_accept"):
			print("このねーむで行くぜ！")
		if event.is_action_pressed("ui_cancel"):
			name_label.text = ""
			name_label.hide()

func on_moji_in(input_char : String):
	name_string += input_char

func _on_yarinaosi_body_entered(body):
	if body.name == "Player":
		press_rto_restart.show()

func _on_player_harakiri():
	press_rto_restart.show()


func _on_player_kononamae():
	is_this_name.show()
	name_label.text = name_string
	name_label.show()
	pass # Replace with function body.
