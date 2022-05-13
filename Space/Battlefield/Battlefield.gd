extends Node2D
var paused = false
var game_over = false

func _ready() -> void:
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_node("Press").set_visible(false)
	get_node("GameOver").set_visible(false)
	get_node("ToReset").set_visible(false)
	get_node("PlayStationButtonO").set_visible(false)
	get_node("Pause").set_visible(false)
	
	var temp_name: = "temp"
	var invader = get_node("Invader1")
	
	var amount_of_enemies = 40
	var amount_of_enemies_variable = amount_of_enemies + 1
	
	for k in amount_of_enemies_variable:
		
		if k != 0:
			temp_name = "Invader" + str(k)
			invader = get_node(temp_name)
			for n in amount_of_enemies_variable:
				if n != 0:
					invader.connect("left_wall_bounce", get_node("Invader" + str(n)), "_on_left_wall_bounce")
					invader.connect("right_wall_bounce", get_node("Invader" + str(n)), "_on_right_wall_bounce")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
	if game_over == false:
		if Input.is_action_just_pressed("pause"):
			if paused == false:
				get_tree().paused = true
				paused = true
				get_node("Pause").set_visible(true)
			else:
				get_tree().paused = false
				paused = false
				get_node("Pause").set_visible(false)
			
func _on_Defender_tree_exited() -> void:
	get_node("Press").set_visible(true)
	get_node("GameOver").set_visible(true)
	get_node("ToReset").set_visible(true)
	get_node("PlayStationButtonO").set_visible(true)
	game_over = true
