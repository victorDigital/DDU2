extends Node2D

var f = load("res://Assets/Fonts/Jersey10-Regular.ttf")
var window
var menu_button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window = get_viewport().size
	menu_button = Button.new()
	menu_button.text = "Back to the menu"
	menu_button.set_size(Vector2(200, 60))
	menu_button.set_position(Vector2(window.x/2-100, window.y/2))
	menu_button.pressed.connect(self._main_menu)
	add_child(menu_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw():
	draw_rect(Rect2(Vector2(0,0), window), Color(255,255,255))
	draw_string(f, Vector2(window.x/2-150, window.y/2-80), ("Player " + str(Global.lastWinner) + " Won!"), HORIZONTAL_ALIGNMENT_CENTER, 300, 38, Color(0,0,0))
	
func _main_menu():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
