extends KinematicBody2D

export var speed: = 200
var velocity = Vector2(0.0, -1 * speed)

func _ready() -> void:
	pause_mode = Node.PAUSE_MODE_STOP
	
func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name != "TileMap":
			# here we delete the enemy
			#print("deleting enemy = " + collision.collider.name)
			var bumped = get_tree().get_root().get_node("Battlefield").get_node(collision.collider.name)
			# get_parent().get_node(self.name).disconnect("left_wall_bounce", get_parent().get_node(self.name), "_on_left_wall_bounce")
			# get_parent().get_node(self.name).disconnect("right_wall_bounce", get_parent().get_node(self.name), "_on_right_wall_bounce")
			bumped.queue_free()
			#get_tree().get_root().remove_child(get_tree().get_root().get_node(bumped))
		#print("deleting pulse")
		get_parent().get_node(self.name).queue_free()
