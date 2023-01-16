extends KinematicBody2D

var pulse = preload("res://Defender/Pulse.tscn")

var pulse_count
var timer
var pulse_available: = 1
var velocity: = Vector2.ZERO

export var strength: = 200.0
export var time_between_shots: = 0.5



func _ready() -> void:
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)
	timer.wait_time = time_between_shots
	pulse_count = 0

func _physics_process(delta: float) -> void:
	var direction: = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0.0)
	velocity = strength * direction
	velocity = move_and_slide(velocity, Vector2.UP)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and pulse_available == 1:
		# set the pulse availibality to 0
		# set the timer off
		pulse_available = 0
		timer.start()
		# instantiate the pulse
		var pulseInstance = pulse.instance()
		pulseInstance.name = "Pulse" + str(pulse_count)
		pulse_count += 1
		pulseInstance.scale = Vector2(0.05, 0.05)
		pulseInstance.position = Vector2(position.x, position.y + 20)
		# add pulse to node tree
		get_tree().get_root().get_node("Battlefield").add_child_below_node(get_tree().get_root().get_node("Battlefield").get_node("TileMap"),pulseInstance)
		
		
func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return 1
		elif collision.normal.x < 0:
			return -1
	return "none"
	
func _on_timer_timeout():
	pulse_available = 1
