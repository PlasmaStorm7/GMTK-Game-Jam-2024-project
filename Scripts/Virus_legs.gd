extends Node3D
@export var num_tentacles = 2
@export var segments_per_tentacle = 5
@export var segment_length = 1.0
@export var segment_radius = 0.2
@export var radius = 0.45  # Radius of the circle on which tentacles are placed
@export var desired_spacing = 0.5  # Desired arc length between tentacle bases

func _ready():
	for i in range(num_tentacles):
		var angle = deg_to_rad(360.0 / num_tentacles * i )
		var tentacle_base = create_tentacle(i)
		# Calculate position on the circle's circumference
		var x = radius * cos(angle)
		var z = radius * sin(angle)
		tentacle_base.translate(Vector3(x, 0, z))
		# Rotate tentacle to face outwards from the center using local rotation
		tentacle_base.rotate_y(angle)
		# Then tilt forward around the local X-axis
		#tentacle_base.rotation_degrees.x = 80
		add_child(tentacle_base)

func create_tentacle(index):
	var parent = Node3D.new()  # Root node for this tentacle
	var current_node = parent

	# Create a shader material
	var material = ShaderMaterial.new()
	material.shader = Shader.new()
	material.shader.code = """
		shader_type spatial;
		
		void fragment() {
			ALBEDO = vec3(0.16, 0.0, 0.23);  // RGB for violet color
			RIM = 0.2;
			METALLIC = 0.1;
			ROUGHNESS = 0.7;
		}
	"""

	for j in range(segments_per_tentacle):
		# Create a new pivot node for this segment
		if j != 0:
			var pivot = Node3D.new()
			current_node.add_child(pivot)
			current_node = pivot
			pivot.translate(Vector3(0, -(segment_length - segment_radius), 0))
		
		# Create the mesh instance for this segment
		var segment = MeshInstance3D.new()
		segment.mesh = CapsuleMesh.new()
		(segment.mesh as CapsuleMesh).height = segment_length
		(segment.mesh as CapsuleMesh).radius = segment_radius - j * 0.02  # Gradually taper the tentacle
		segment.translate(Vector3(0, -(segment_length / 2), 0))
		
		# Assign the shader material to the segment
		segment.material_override = material
		
		current_node.add_child(segment)

	return parent


var amplitude_base = 0.2  # Base amplitude for the root of the tentacle
var amplitude_increment = 0.1  # Incremental amplitude increase per segment from base to tip
var amplitude_offset = 10
# Assume a static or member variable to accumulate time
var accumulated_time = 0.0

func _process(delta):
	# Accumulate time
	accumulated_time += delta
	# Start the animation process from the root for each tentacle
	var tentacle_count = get_child_count()
	for tentacle_index in range(tentacle_count):
		var tentacle = get_child(tentacle_index)
		# Calculate a tentacle-specific phase offset
		var tentacle_phase_offset = tentacle_index * 0.5  # Adjust this value to change the phase difference between tentacles
		animate_tentacles(tentacle, 0, tentacle_phase_offset, tentacle_index)

func animate_tentacles(node, depth, phase_offset, ith_tentacle):
	# Calculate time factor for the oscillation cycle
	var time_factor = accumulated_time * 0.5 * PI  # Slower oscillation cycle

	# Recursively apply oscillation to each child node
	for child_index in range(node.get_child_count()):
		if child_index == 1:
			var child = node.get_child(child_index)
			animate_tentacles(child, depth + 1, phase_offset, ith_tentacle)

	# Calculate oscillation amplitude - it increases with depth
	var amplitude = amplitude_base + amplitude_increment * depth
	# Calculate phase shift to create a wave effect from base to tip
	var phase_shift = depth * 0.7 + phase_offset  # Include tentacle-specific phase offset
	# Oscillate the node around the y-axis'
	if ith_tentacle % 2 == 0:
		node.rotation_degrees.z = amplitude_offset + amplitude * sin(phase_shift + time_factor) * 180 / PI  # Apply sine and convert radians to degrees
	else: 
		node.rotation_degrees.z = -amplitude_offset + amplitude * sin(phase_shift + time_factor) * 180 / PI  # Apply sine and convert radians to degrees
		
