extends TextEdit

var items = []
@onready var v_box_container = $"../../ScrollContainer/VBoxContainer"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize with the list elements
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sequencer_h_box_molecule_added(letter):
	text += letter
	items = v_box_container.get_children()
	# List of matches
	var matches = []
	# Lowercase text for search
	var search_text = text.to_lower()
	print(search_text)
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
