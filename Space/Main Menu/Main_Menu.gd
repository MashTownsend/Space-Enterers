extends Node2D

onready var text_controller = get_node("connect_controller")
onready var text_press = get_node("press")
onready var text_to_start = get_node("to start")
onready var text_x_button = get_node("x_button")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	text_controller.show()
	text_press.hide()
	text_to_start.hide()
	text_x_button.hide()
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	if Input.get_connected_joypads().size() > 0:
		text_controller.hide()
		text_press.show()
		text_to_start.show()
		text_x_button.show()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start_game"):
		get_tree().change_scene("res://Battlefield/Battlefield.tscn")
	
func _on_joy_connection_changed(device_id, connected):
	if connected:
		text_controller.hide()
		text_press.show()
		text_to_start.show()
		text_x_button.show()
	else:
		text_controller.show()
		text_press.hide()
		text_to_start.hide()
		text_x_button.hide()
