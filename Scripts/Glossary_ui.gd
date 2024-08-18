extends Control

var valid_sequences = {
		"AADJ": {
			"immunity" : +1,
			"hp" : 0,
			"strength": 0
		}, 
		"JAJA": {	
			"immunity" : 0,
			"hp" : +1,
			"strength": 0
		},
		 "LADA": {	
			"immunity" : 0,
			"hp" : 0,
			"strength": +1
		},
		"JLAD": {	
			"immunity" : 0,
			"hp" : -1,
			"strength": +3
		},
		"DAJA": {	
			"immunity" : -2,
			"hp" : +4,
			"strength": 0
		},
		"LALA": {	
			"immunity" : -1,
			"hp" : -1,
			"strength": +4
		},
		"LAJD": {	
			"immunity" : +3,
			"hp" : +3,
			"strength": -5
		}
	}
var hp = 5
var immunity = 0
var strength = 3

@onready var v_box_container = $ScrollContainer/VBoxContainer


func create_sequence(name):
	var path = "res://Scenes/Nucleotide/" + name + ".tscn"
	var scene = ResourceLoader.load(path)
	var instance = scene.instantiate()
	return instance

func _ready():
	for sequence in valid_sequences.keys():
		var nucleotide_name = sequence
		var first_nucleotide = nucleotide_name.substr(0,2)
		var second_nucleotide = nucleotide_name.substr(2,2)
		var scene = ResourceLoader.load("res://Scenes/Glossary/Glossary_element.tscn")
		var instance = scene.instantiate()
		instance.set_custom_minimum_size(Vector2(0, 110)) 
		instance.get_node("Name").bbcode_enabled = true
		instance.get_node("Name").set_text("[center]" + nucleotide_name + "[/center]")
		instance.get_node("Stats").bbcode_enabled = true
		instance.get_node("Stats").set_text("[center]" 
		+ "HP: " + str(valid_sequences[nucleotide_name].hp) + "\n"
		+ "Immunity: " + str(valid_sequences[nucleotide_name].immunity) + "\n"
		+ "strength: " + str(valid_sequences[nucleotide_name].strength)
		+ "[/center]")
		instance.get_node("Sequence").add_child(create_sequence(first_nucleotide))
		instance.get_node("Sequence").add_child(create_sequence(second_nucleotide))
		v_box_container.add_child(instance)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
