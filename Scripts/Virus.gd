extends CharacterBody3D

# Minimum and maximum speed
@export var min_speed: float = 10 
@export var max_speed: float = 18 

func _physics_process(delta):
	# Move the character based on the computed velocity
	move_and_slide()

func initialize(start_position, player_position):
	global_transform.origin = start_position  # Set the starting position
	self.look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_object_local(Vector3.RIGHT,  -90 / (180/PI) )
	
	scale = Vector3(0.1, 0.1, 0.1)
	# Calculate the direction vector pointing towards the player
	var direction = (player_position - start_position).normalized()

	# Calculate a random speed within the specified range
	var speed = randi_range(min_speed, max_speed)
	
	# Set the velocity vector
	velocity = direction * speed


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
