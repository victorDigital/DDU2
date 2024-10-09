extends Node

var audio_muted = false

func toggle_audio():
	var master_bus_index = AudioServer.get_bus_index("Master")
	if audio_muted:
		AudioServer.set_bus_volume_db(master_bus_index, 0)  # Unmute
		audio_muted = false
	else:
		AudioServer.set_bus_volume_db(master_bus_index, -80)  # Mute
		audio_muted = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
