extends Node

var base_dmg = 0.2
var base_growth = 1
# Signal definitions
signal deal_damage(damage1,damage2,damage3)
signal grow_potatoes(potato_amount)
# Scene to instantiate
@export var template_scene: PackedScene

var valid_sequences = {
		"JJDJ": {
			"dodecahedron" : +1,
			"icosahedron" : 0,
			"octahedron": 0,
			"potato": +1
		}, 
		"JAJA": {	
			"dodecahedron" : 0,
			"icosahedron" : +1,
			"octahedron": 0,
			"potato": +1
		},
		 "LADJ": {	
			"dodecahedron" : 0,
			"icosahedron" : 0,
			"octahedron": +1,
			"potato": +1
		},
		"JLAD": {	
			"dodecahedron" : +1,
			"icosahedron" : +1,
			"octahedron": +1,
			"potato": -1
		},
		"DAJJ": {	
			"dodecahedron" : -1,
			"icosahedron" : -1,
			"octahedron": -1,
			"potato": +4
		},
		"LDLJ": {	
			"dodecahedron" : +3,
			"icosahedron" : 0,
			"octahedron": 0,
			"potato": -2
		},
		"LDJD": {	
			"dodecahedron" : 0,
			"icosahedron" : +2,
			"octahedron": 0,
			"potato": -1
		},
		"AJJA":{
			"dodecahedron" : 0,
			"icosahedron" : 0,
			"octahedron": +2,
			"potato": -1
		}
	}


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

	if valid_sequences.has(last_sequence):
		emit_signal("deal_damage", base_dmg + valid_sequences[last_sequence]["octahedron"], base_dmg + valid_sequences[last_sequence]["icosahedron"], base_dmg + valid_sequences[last_sequence]["dodecahedron"])
		emit_signal("grow_potatoes", base_growth + valid_sequences[last_sequence]["potato"])
	else:
		emit_signal("deal_damage", base_dmg, base_dmg, base_dmg )
		emit_signal("grow_potatoes", base_growth)
