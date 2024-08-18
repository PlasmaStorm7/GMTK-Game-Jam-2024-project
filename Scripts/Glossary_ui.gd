extends Control

var nucleotide_names = []
@onready var v_box_container = $ScrollContainer/VBoxContainer

func list_nucleotides():
	var path = "res://Scenes/Nucleotide/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				nucleotide_names.append(file_name.split(".")[0].to_upper())
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func create_sequence(name):
	var path = "res://Scenes/Nucleotide/" + name + ".tscn"
	var scene = ResourceLoader.load(path)
	var instance = scene.instantiate()
	return instance

func _ready():
	list_nucleotides()
	for first_nucleotide in nucleotide_names:
		for second_nucleotide in nucleotide_names:
			var nucleotide_name = first_nucleotide + second_nucleotide
			var scene = ResourceLoader.load("res://Scenes/Glossary/Glossary_element.tscn")
			var instance = scene.instantiate()
			instance.set_custom_minimum_size(Vector2(0, 110)) 
			instance.get_node("Name").bbcode_enabled = true
			instance.get_node("Name").set_text("[center]" + nucleotide_name + "[/center]")
			instance.get_node("Stats").bbcode_enabled = true
			instance.get_node("Stats").set_text("[center]" + nucleotide_name + "[/center]")
			instance.get_node("Sequence").add_child(create_sequence(first_nucleotide))
			instance.get_node("Sequence").add_child(create_sequence(second_nucleotide))
			v_box_container.add_child(instance)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
