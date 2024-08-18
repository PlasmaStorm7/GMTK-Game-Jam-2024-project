extends Node

@export var mob_scene: PackedScene
@export var DNA_scene: NodePath


func _unhandled_input(event):
	
	if Input.is_action_just_pressed("pause"):
		print("pressed ESC")
		get_tree().paused=not get_tree().paused
		
func _on_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = Vector3(0,0,0);
	var character = get_node(DNA_scene)
	if character:
		player_position = character.global_transform.origin
		
	mob.initialize(mob_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
