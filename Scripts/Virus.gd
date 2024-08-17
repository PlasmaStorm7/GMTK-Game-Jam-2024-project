extends CharacterBody3D

# Minimum and maximum speed
@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	# Move the character based on the computed velocity
	move_and_slide()

func initialize(start_position, player_position):
	global_transform.origin = start_position  # Set the starting position
	self.rotation.x = 0
	self.rotation.z = 0
	self.look_at(player_position, Vector3.UP)
	self.rotation.y = 90

	scale = Vector3(0.1, 0.1, 0.1)
	# Calculate the direction vector pointing towards the player
	var direction = (player_position - start_position).normalized()

	# Calculate a random speed within the specified range
	var speed = randi_range(min_speed, max_speed)
	
	# Set the velocity vector
	velocity = direction * speed


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
