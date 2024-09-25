extends Node2D


@onready var p1 = $player_1  # Assuming you have a Player node
@onready var p2 = $player_2  # Assuming you have a Player node

@onready var h1 = $Player1Health  # Assuming you have a Health UI node
@onready var h2 = $Player2Health  # Assuming you have a Health UI node


func _ready() -> void:
	p1.connect("p1_health_changed", Callable(h1, "_on_health_changed"))
	p2.connect("p2_health_changed", Callable(h2, "_on_health_changed"))
	p1.connect("player_dead", Callable(self, "_game_over"))
	p2.connect("player_dead", Callable(self, "_game_over"))
	
func _game_over(i):
	if i == 1:
		Global.lastWinner = 2
	elif i == 2:
		Global.lastWinner = 1
	else:
		Global.lastWinner = 0
	get_tree().change_scene_to_file("res://Scenes/end.tscn")
