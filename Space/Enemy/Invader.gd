extends KinematicBody2D

class_name Invader

var laser = preload("res://Enemy/Laser.tscn")

export var time_between_shots = 0.5
export var init_speed: = 200.0
var speed: = init_speed
export var percentage_increase = 10
export var probablity_of_a_shot = 20

var bumped
signal left_wall_bounce
signal right_wall_bounce
var velocity: = Vector2.ZERO
var timer
var rng

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)
	timer.wait_time = time_between_shots
	timer.start()

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

	
	if velocity.x == 0.0:
		velocity.x = -1 * speed
		
	if is_on_wall() == true:
		if get_which_wall_collided() == 1:
			#velocity.x = 1 * speed
			#print("bounced on left wall")
			emit_signal("left_wall_bounce")
			
		elif get_which_wall_collided() == -1:
			#velocity.x = -1 * speed
			#print("bounced on right wall")
			emit_signal("right_wall_bounce")
			
		elif get_which_wall_collided() == 0:
			get_tree().get_root().get_node("Battlefield").remove_child(get_tree().get_root().get_node("Battlefield").get_node(bumped))
			get_parent().remove_child(self)
		
		elif get_which_wall_collided() == "none":
			print("none")
			
func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider.name != "TileMap":
			bumped = collision.collider.name
			return 0
			
		if collision.collider.name == "TileMap":
			if collision.normal.x > 0:
				return 1 # left
			elif collision.normal.x < 0:
				return -1
	return "none"

func move_down():
	var temp_vel: = Vector2(0.0, -500.0)
	temp_vel = move_and_slide(temp_vel, Vector2.UP)

func _on_left_wall_bounce():
	move_down()
	speed = init_speed * (100 + percentage_increase)/100
	velocity.x = 1 * speed
	velocity.y = 0.0
#
func _on_right_wall_bounce():
	move_down()
	speed = speed * 1.1
	velocity.x = -1 * speed
	velocity.y = 0.0
	
func _on_timer_timeout():
	# produce a random number
	rng.randomize()
	var my_random_number = rng.randf() # 0.0 - 1.0 (inclusive)
	var percent = probablity_of_a_shot/100.0
	#print(my_random_number)
	if my_random_number < percent:
		var laserInstance = laser.instance()
		laserInstance.scale = Vector2(0.05, 0.05)
		laserInstance.position = Vector2(position.x, position.y - 20)
		get_tree().get_root().get_node("Battlefield").add_child_below_node(get_tree().get_root().get_node("Battlefield").get_node("TileMap"),laserInstance)
	timer.start()
