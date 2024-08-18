extends Node

const initial_strand = 1
const strand_number = 6

@onready var music: AudioStreamPlayer = $Music
@onready var sync: AudioStreamSynchronized = music.stream
@onready var main_theme: AudioStreamPlayer = $MainTheme

# Called when the node enters the scene tree for the first time.
# Prepares music by silencing unneeded tracks
func _ready() -> void:
	#start_main_theme()
	sync.set_sync_stream_volume(initial_strand, 0.0)
	
func start_game_music() -> void:
	main_theme.stop()
	music.play()
	
func start_main_theme() -> void:
	music.stop()
	main_theme.play()

var _current_strand = initial_strand
var _next_strand = initial_strand
	
# Call this function to change the strand and music
# Strand numbering starts from 1 and goes until `strand_number`
func change_strand(strand: int) -> void:
	if strand == _next_strand:
		return
	_next_strand = strand
	_crossfade()

# Crossfades song tracks over 0.4 seconds (if timer works correctly)
func _crossfade():
	for i in 20:
		var level = i*3
		sync.set_sync_stream_volume(_next_strand, level-60)
		await get_tree().create_timer(0.01).timeout
	for i in 20:
		var level = i*3
		sync.set_sync_stream_volume(_current_strand, -level)
		await get_tree().create_timer(0.01).timeout
	_current_strand = _next_strand
