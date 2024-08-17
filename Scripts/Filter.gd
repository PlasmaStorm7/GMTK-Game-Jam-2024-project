extends TextEdit

var items = []

func _on_text_changed():
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
		if search_text in item.get_node("RichTextLabel").text:
			matches.append(item)
	# Show only the elements that we use
	for item in items:
		if item in matches:
			item.show()
		else:
			item.hide()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize with the list elements
	items = $"../../ScrollContainer/VBoxContainer".get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
