extends HBoxContainer
var red:= preload("res://Scenes/Sequencer/circle_red.tscn")
var purple:= preload("res://Scenes/Sequencer/circle_purple.tscn")
var yellow:= preload("res://Scenes/Sequencer/circle_yellow.tscn")
var blue:= preload("res://Scenes/Sequencer/circle_blue.tscn")
var bara:=preload("res://Scenes/Sequencer/bara2D.tscn")
var vbox:= preload("res://Scenes/Sequencer/v_box_container_de_nucleotide.tscn")
@onready var timer: Timer = $Timer


signal sequence_completed(length:int,sequence:String)
signal molecule_added(letter:String)

var vboxVector= Array()
var instanceVector = Array()
var inputVector: String
var i:int=0
var j:int=0
var delayed:bool=false
@export_range(4, 32, 4) var MAX_ELEMENTS :int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vboxVector.append(vbox.instantiate())
	add_child(vboxVector[-1])
	
func _afterPress() -> void:
	i+=1
	j+=1
	_sequenceBreak()
	
func _sequenceBreak() -> void:
	if j>=MAX_ELEMENTS:
		timer.start()
		delayed=true
		#print(inputVector)
		sequence_completed.emit(MAX_ELEMENTS,inputVector)
		inputVector=""
		j=0
		i=0
		
		
	if i>=2 :
		vboxVector.append(vbox.instantiate())
		add_child(vboxVector[-1])
		#print("added a vertBox")
		i=0
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if delayed:
		return
	
	if Input.is_action_just_pressed("adenozine"):
		if i==1:
			instanceVector.append(bara.instantiate())
			vboxVector[-1].add_child(instanceVector[-1])
		instanceVector.append(blue.instantiate())
		vboxVector[-1].add_child(instanceVector[-1])
		inputVector+='A'
		molecule_added.emit("A")
		_afterPress()
		return
		
	if Input.is_action_just_pressed("dinozine"):
		if i==1:
			instanceVector.append(bara.instantiate())
			vboxVector[-1].add_child(instanceVector[-1])
		instanceVector.append(red.instantiate())
		vboxVector[-1].add_child(instanceVector[-1])
		inputVector+='D'
		molecule_added.emit("D")
		_afterPress()
		return
		
	if Input.is_action_just_pressed("jinozine"):
		if i==1:
			instanceVector.append(bara.instantiate())
			vboxVector[-1].add_child(instanceVector[-1])
		instanceVector.append(purple.instantiate())
		vboxVector[-1].add_child(instanceVector[-1])
		inputVector+='J'
		molecule_added.emit("J")
		_afterPress()
		return
		
	if Input.is_action_just_pressed("limozine"):
		if i==1:
			instanceVector.append(bara.instantiate())
			vboxVector[-1].add_child(instanceVector[-1])
		instanceVector.append(yellow.instantiate())
		vboxVector[-1].add_child(instanceVector[-1])
		inputVector+='L'
		molecule_added.emit("L")
		_afterPress()
		return
	
		
		


func _on_timer_timeout() -> void:
	for boxes in vboxVector:
		#print("hello"+str(boxes))
		if is_instance_valid(boxes):
			boxes.queue_free()
	vboxVector.append(vbox.instantiate())
	add_child(vboxVector[-1])
	delayed=false
