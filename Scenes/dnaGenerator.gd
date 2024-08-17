extends Node

@export var camera_ref: Camera3D
@export var curva: Curve
var prev_instance: Node = null
var dna_node = preload("res://Scenes/baraCuCerc.tscn")
var building_y: float = 0;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	building_y=self.get_parent().position.y;
	camera_ref= self.get_parent().get_parent().find_child("Camera3D")
	pass # Replace with function body.


func _unhandled_input(event):
	if event is InputEventKey:
			var instance = dna_node.instantiate();

			if event.is_released() and event.keycode == KEY_A:
				var msh: MeshInstance3D= instance.find_child("sfera1").find_child("MeshInstance3D")
				msh.mesh.material.set_shader_parameter("albedo",Vector4(0,0,1,1))
			if event.is_released() and event.keycode == KEY_D:
				var msh: MeshInstance3D= instance.find_child("sfera1").find_child("MeshInstance3D")
				msh.mesh.material.set_shader_parameter("albedo",Vector4(1,0,0,1))
			if event.is_released() and event.keycode == KEY_J:
				var msh: MeshInstance3D= instance.find_child("sfera1").find_child("MeshInstance3D")
				msh.mesh.material.set_shader_parameter("albedo",Vector4(1,0,1,1))
			if event.is_released() and event.keycode == KEY_L:
				var msh: MeshInstance3D= instance.find_child("sfera1").find_child("MeshInstance3D")
				msh.mesh.material.set_shader_parameter("albedo",Vector4(0.5,1,0.5,1))
				
			if event.is_released():
				
				if(prev_instance != null):
					instance.position = Vector3(0,prev_instance.position.y+0.5,self.get_parent().position.z)
					instance.rotation = Vector3(0,prev_instance.rotation.y+1,0);
				else:
					instance.position = Vector3(0,0,self.get_parent().position.z)

				
				var anim:AnimationPlayer= instance.find_child("AnimationPlayer")
				anim.play("spin")

				add_child(instance)
				prev_instance=instance
				camera_ref.position.y=prev_instance.position.y+0.5

			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
