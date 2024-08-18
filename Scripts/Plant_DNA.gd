extends Node
# Scene to instantiate
@export var template_scene: PackedScene

var last_sequence = "ADJL"
var second = false
var map_color = {
	"A": Color(0.157, 0.482, 1.000),
	"D": Color(1.000, 0.173, 0.173),
	"J": Color(0.690, 0.173, 0.988),
	"L": Color(0.973, 0.737, 0.016),
}
func create_sequence(sequence: String):
	var index = 0
	if second:
		index = 2
	var instance = template_scene.instantiate()

	instance.sphere_color1 = map_color[sequence[0 + index]]
	instance.cylinder_color1 = Color(0.673, 0.737, 0.616)
	instance.sphere_color2 = map_color[sequence[1 + index]]
	instance.cylinder_color2 = Color(0.673, 0.737, 0.616)
	
	add_child(instance)
	second = !second
	

func _on_sequencer_h_box_sequence_completed(length: int, sequence: String) -> void:
	last_sequence=sequence


func _on_timer_plant_dna_timeout() -> void:
	create_sequence(last_sequence)
