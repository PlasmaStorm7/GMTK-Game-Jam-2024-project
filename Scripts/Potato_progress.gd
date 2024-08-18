extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update(potato_value):
	value = potato_value


func _on_text_edit_update_potato(potato_value):
	#print(potato_value)
	update(potato_value)
