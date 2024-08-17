extends MeshInstance3D

func _ready():
	var vertices = PackedVector3Array([
		Vector3(1, 1, 1),   # Vertex 0
		Vector3(-1, -1, 1), # Vertex 1
		Vector3(-1, 1, -1), # Vertex 2
		Vector3(1, -1, -1)  # Vertex 3
	])

	var indices = PackedInt32Array([
		0, 1, 2,
		3, 1, 0,
		0, 2, 3,
		3, 2, 1
	])

	var normals = PackedVector3Array([
		# Calculate these using cross product of edges of each triangle
		(vertices[1] - vertices[0]).cross(vertices[2] - vertices[0]).normalized(), # Normal for face 0
		(vertices[1] - vertices[0]).cross(vertices[3] - vertices[0]).normalized(), # Normal for face 1
		(vertices[2] - vertices[0]).cross(vertices[3] - vertices[0]).normalized(), # Normal for face 2
		(vertices[2] - vertices[1]).cross(vertices[3] - vertices[1]).normalized()  # Normal for face 3
	])

	var uvs = PackedVector2Array([
		# Simple UV mapping
		Vector2(0.5, 1.0),
		Vector2(1.0, 0.0),
		Vector2(0.0, 0.0),
		Vector2(0.5, 0.5)  # Arbitrarily mapping the fourth vertex
	])


	var mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_INDEX] = indices
	arrays[ArrayMesh.ARRAY_NORMAL] = normals
	arrays[ArrayMesh.ARRAY_TEX_UV] = uvs

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	self.mesh = mesh
	
	var material = ShaderMaterial.new()
	material.shader = preload("res://Assets/shaders/virus_color.gdshader")
	material.set_shader_parameter("color0", Color(1, 0, 0)) # Red
	material.set_shader_parameter("color1", Color(0, 1, 0)) # Green
	material.set_shader_parameter("color2", Color(0, 0, 1)) # Blue
	material.set_shader_parameter("color3", Color(1, 1, 0)) # Yellow
	self.mesh.surface_set_material(0, material)
