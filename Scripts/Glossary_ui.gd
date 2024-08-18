extends Control

var valid_sequences = {
		"JJDJ": {
			"dodecahedron" : +1,
			"icosahedron" : 0,
			"octahedron": 0,
			"potato": +1,
			"strand": 1
		}, 
		"JAJA": {	
			"dodecahedron" : 0,
			"icosahedron" : +1,
			"octahedron": 0,
			"potato": +1,
			"strand": 2
		},
		 "LADJ": {	
			"dodecahedron" : 0,
			"icosahedron" : 0,
			"octahedron": +1,
			"potato": +1,
			"strand": 3
		},
		"JLAD": {	
			"dodecahedron" : +1,
			"icosahedron" : +1,
			"octahedron": +1,
			"potato": -1,
			"strand": 4
		},
		"DAJJ": {	
			"dodecahedron" : -1,
			"icosahedron" : -1,
			"octahedron": -1,
			"potato": +4,
			"strand": 5
		},
		"LDLJ": {	
			"dodecahedron" : +3,
			"icosahedron" : 0,
			"octahedron": 0,
			"potato": -2,
			"strand": 6
		},
		"LDJD": {	
			"dodecahedron" : 0,
			"icosahedron" : +2,
			"octahedron": 0,
			"potato": -1,
			"strand": 1
		},
		"AJJA":{
			"dodecahedron" : 0,
			"icosahedron" : 0,
			"octahedron": +2,
			"potato": -1,
			"strand": 2
		}
	}
	

@onready var v_box_container = $ScrollContainer/VBoxContainer
@onready var progress_bar = $ProgressBar


func create_sequence(name):
	var path = "res://Scenes/Nucleotide/" + name + ".tscn"
	var scene = ResourceLoader.load(path)
	var instance = scene.instantiate()
	return instance
	
func create_stat(name):
	var path = "res://Scenes/Icons/" + name + ".tscn"
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
		
		if valid_sequences[nucleotide_name].potato > 0:
			instance.get_node("Stats").add_child(create_stat("potato_up"))
		elif valid_sequences[nucleotide_name].potato < 0:
			instance.get_node("Stats").add_child(create_stat("potato_down"))
			
		if valid_sequences[nucleotide_name].octahedron > 0:
			instance.get_node("Stats").add_child(create_stat("octahedron_up"))
		elif valid_sequences[nucleotide_name].octahedron < 0:
			instance.get_node("Stats").add_child(create_stat("octahedron_down"))
			
		if valid_sequences[nucleotide_name].dodecahedron > 0:
			instance.get_node("Stats").add_child(create_stat("dodecahedron_up"))
		elif valid_sequences[nucleotide_name].dodecahedron < 0:
			instance.get_node("Stats").add_child(create_stat("dodecahedron_down"))
			
		if valid_sequences[nucleotide_name].icosahedron > 0:
			instance.get_node("Stats").add_child(create_stat("icosahedron_up"))
		elif valid_sequences[nucleotide_name].icosahedron < 0:
			instance.get_node("Stats").add_child(create_stat("icosahedron_down"))
		
		
		instance.get_node("Sequence").add_child(create_sequence(first_nucleotide))
		instance.get_node("Sequence").add_child(create_sequence(second_nucleotide))
		v_box_container.add_child(instance)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
