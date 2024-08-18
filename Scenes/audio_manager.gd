extends Node

const initial_strand = 1
const strand_number = 6

@onready var music: AudioStreamPlayer = $Music
@onready var sync: AudioStreamSynchronized = music.stream

# Called when the node enters the scene tree for the first time.
# Prepares music by silencing unneeded tracks
func _ready() -> void:
	start_music() # delete this call after music is started programatically
	sync.set_sync_stream_volume(initial_strand, 0.0)
	
func start_music() -> void:
	music.play()

var _current_strand = initial_strand
var _next_strand = initial_strand
	
# Call this function to change the strand and music
# Strand numbering starts from 1
func change_strand(strand: int) -> void:
	if strand == _next_strand:
		return
	_next_strand = strand
	_crossfade()

# Crossfades song tracks over 0.4 seconds (if timer works correctly)
func _crossfade():
	for i in 20:
		var level = i*4
		
		sync.set_sync_stream_volume(_next_strand, level-80)
		await get_tree().create_timer(0.01).timeout
	for i in 20:
		var level = i*4
		sync.set_sync_stream_volume(_current_strand, -level)
		await get_tree().create_timer(0.01).timeout
	_current_strand = _next_strand
	
	
# Press V to crossfade between the 2 tracks
func _input(ev):
	if Input.is_key_pressed(KEY_V):
		var new_strand = _current_strand + 1
		if new_strand > strand_number:
			new_strand = 1
		change_strand(new_strand)
