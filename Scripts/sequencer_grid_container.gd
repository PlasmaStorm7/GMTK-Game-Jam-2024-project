extends GridContainer

var red = preload("res://Scenes/Sequencer/circle_red.tscn")
var purple = preload("res://Scenes/Sequencer/circle_purple.tscn")
var yellow = preload("res://Scenes/Sequencer/circle_yellow.tscn")
var blue = preload("res://Scenes/Sequencer/circle_blue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var instanceVector = Array()
var i:int=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("adenozine"):
		instanceVector.append(blue.instantiate())
		add_child(instanceVector[-1])
		
	if Input.is_action_just_pressed("dinozine"):
		instanceVector.append(red.instantiate())
		add_child(instanceVector[-1])
		
	if Input.is_action_just_pressed("jinozine"):
		instanceVector.append(yellow.instantiate())
		add_child(instanceVector[-1])
		
	if Input.is_action_just_pressed("limozine"):
		instanceVector.append(purple.instantiate())
		add_child(instanceVector[-1])
