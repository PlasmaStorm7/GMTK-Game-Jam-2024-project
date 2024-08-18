extends Node3D

@export var ball1 :MeshInstance3D
@export var ball2 :MeshInstance3D
var RED = Vector4(1,0,0,1)
var BLUE =Vector4(0,0,1,1)
var YELLOW =Vector4(0.6,1,0.5,1)
var GREEN = Vector4(0,1,0,1)
var PURPLE = Vector4(1,0,1,1)

func translateInput(co: String)->Vector4:
	match co:
		'D':
			return RED
		'J':
			return PURPLE
		'A':
			return BLUE
		'L':
			return YELLOW
		_:
			return GREEN


func colorBall1(c:String)->void:
	ball1.set_instance_shader_parameter("albedo",translateInput(c))
func colorBall2(c:String)->void:
	ball2.set_instance_shader_parameter("albedo",translateInput(c))
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
