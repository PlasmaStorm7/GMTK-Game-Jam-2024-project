extends CharacterBody3D

# Minimum and maximum speed
@export var min_speed: float = 10 
@export var max_speed: float = 18 

# Acceleration and deceleration interval (in seconds)
@export var accel_interval: float = 1.6266  # Approximately every 1/3th of a second

# Speed change variables
var current_speed: float = 0.2
var target_speed: float = 1
var time_since_last_change: float = 0
var accel_moment: bool = true
var direction=  Vector3.FORWARD# Where the virus will go

func _physics_process(delta):
	# Update the time since last speed change
	time_since_last_change += delta
	#print(time_since_last_change)
	# If the time interval has passed, update the speed
	if time_since_last_change >= accel_interval:
		time_since_last_change = 0  # Reset the timer
		accel_moment = !accel_moment
		# choose whether to accelerate or decelerate
	if accel_moment:
		#print(minf(current_speed + 0.1, target_speed) ," ", current_speed," ", target_speed)
		current_speed = current_speed + 0.01
	else:
		current_speed = current_speed - 0.009
	
	velocity = direction * current_speed

	# Move the character based on the computed velocity
	move_and_slide()

func initialize(start_position, player_position):
	global_transform.origin = start_position  # Set the starting position
	self.look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_object_local(Vector3.RIGHT,  -90 / (180/PI))
	
	# Set initial scale
	scale = Vector3(0.1, 0.1, 0.1)
	
	# Calculate the direction vector pointing towards the player
	direction = (player_position - start_position).normalized()
	
	# Calculate a random initial target speed within the specified range
	target_speed = randf_range(min_speed, max_speed)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
