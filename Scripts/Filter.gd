extends TextEdit

var items = []
static var potato = 0
@onready var v_box_container = $"../../ScrollContainer/VBoxContainer"
static var active_potato_value = 0
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

signal update_potato(potato_value:int)
# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize with the list elements
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	potato += active_potato_value * delta
	update_potato.emit(int(potato))


func _on_sequencer_h_box_molecule_added(letter):
	text += letter
	items = v_box_container.get_children()
	# List of matches
	var matches = []
	# Lowercase text for search
	var search_text = text.to_lower()
	# If empty then print all
	if search_text == "":
		for item in items:
			item.show()
		return
	# Extract text node and filter by text
	for item in items:
		if item.get_node("Name").text.to_lower().find(search_text) == 8:
			matches.append(item)
	# Show only the elements that we use
	
	for item in items:
		if item in matches:
			item.show()
		else:
			item.hide()


func _on_sequencer_h_box_sequence_completed(length, sequence):
	text = ""
	items = v_box_container.get_children()
	for item in items:
		item.show()
	if sequence.to_upper() in valid_sequences.keys():
		active_potato_value = valid_sequences[sequence.to_upper()].potato
		AudioManager.change_strand(valid_sequences[sequence.to_upper()].strand)
	else:
		active_potato_value = 0
