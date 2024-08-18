extends Node

@export var camera_ref: Camera3D
@export var curva: Curve
@export var beginning_node: Node
var prev_instance: Node = null
var dna_node = preload("res://Scenes/baraCuCerc.tscn")
var building_y: float = 0;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	building_y=beginning_node.position.y;
	camera_ref= self.get_parent().find_child("Camera3D")
	var primary = get_node("/root/DnaView/CanvasLayer/MainGameUI/CanvasLayer/SequencerUi/SequencerHBox")
	primary.sequence_completed.connect("sequence_completed", self, "_on_sequence_completed")
	pass # Replace with function body.


func _on_sequence_completed(length:int,sequence:String):
	
	var instance = dna_node.instantiate();
	var instance_script:Script =  instance.get_script()
	instance_script.colorBall1(sequence[0])
	instance_script.colorBall2(sequence[1])

	
	if(prev_instance != null):
		instance.position = Vector3(0,prev_instance.position.y+0.5,prev_instance.position.z)
		instance.rotation = Vector3(0,prev_instance.rotation.y+1,0);
	else:
		instance.position = Vector3(0,0,beginning_node.position.z)


	var anim:AnimationPlayer= instance.find_child("AnimationPlayer")
	anim.play("spin")

	add_child(instance)
	prev_instance=instance
	camera_ref.position.y=prev_instance.position.y+0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
