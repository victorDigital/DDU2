extends TextureProgressBar

signal p1_health_changed(new_health)

func _ready() -> void:
	# Connect to player's health_changed signal if it's on the same node
	get_tree().connect("p1_health_changed", Callable(self, "_on_health_changed"))

func _on_health_changed(new_health):
	self.value = new_health
	Global.globalHPPlayer1 = new_health
