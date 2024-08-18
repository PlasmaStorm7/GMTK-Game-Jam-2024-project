extends RigidBody3D

# Exposed variables for color
@export var sphere_color1 = Color(1, 0, 0)
@export var cylinder_color1 = Color(0, 1, 0)
@export var sphere_color2 = Color(1, 0, 0)
@export var cylinder_color2 = Color(0, 1, 0)
@export var spin_speed = 1.0
@export var velocity_strength = 5.0


func _ready():
	# Assuming the children are ordered as Sphere1, Cylinder, Sphere2
	var cylinder1 = get_node("nozina")
	var sphere1 = get_node("sugarPhospateBackbone")
	var sphere2 = get_node("sugarPhospateBackbone2")
	var cylinder2 = get_node("nozina2")

	sphere1.material_override = create_material(sphere_color1)
	cylinder1.material_override = create_material(cylinder_color1)
	cylinder2.material_override = create_material(cylinder_color2)
	sphere2.material_override = create_material(sphere_color2)
	
	angular_velocity = Vector3(0, spin_speed, 0)
	linear_velocity = transform.basis.y * velocity_strength

func create_material(color: Color):
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	return material
