extends Control
@onready var patch_red: NinePatchRect = $GridContainer/PatchRed
@onready var patch_purple: NinePatchRect = $GridContainer/PatchPurple
@onready var patch_yellow: NinePatchRect = $GridContainer/PatchYellow
@onready var patch_blue: NinePatchRect = $GridContainer/PatchBlue



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("adenozine"):
		patch_blue.visible=not patch_blue.visible
		
	if Input.is_action_just_pressed("dinozine"):
		patch_red.visible=not patch_red.visible
		
	if Input.is_action_just_pressed("jinozine"):
		patch_purple.visible=not patch_purple.visible
		
	if Input.is_action_just_pressed("limozine"):
		patch_yellow.visible=not patch_yellow.visible
