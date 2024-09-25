extends Node2D

var f = load("res://Assets/Fonts/Jersey10-Regular.ttf")
var window
var p2 = load("res://Assets/Pixel/Main Characters/Ninja Frog/Jump (32x32).png")
var p1 = load("res://Assets/Pixel/Main Characters/Pink Man/Jump (32x32).png")
var winner_image
var scale_factor = 4.5
var menu_button
var background_image = load("res://Assets/Pixel/Background/Blue.png")

func _ready() -> void:
	window = get_viewport().size
	menu_button = Button.new()
	menu_button.text = "Back to the menu"
	menu_button.set_size(Vector2(200, 60))
	menu_button.set_position(Vector2(window.x/2-100, window.y-200))
	menu_button.pressed.connect(self._main_menu)
	add_child(menu_button)
	if Global.lastWinner == 2:
		winner_image = p2
	elif Global.lastWinner == 1:
		winner_image = p1
	else: 
		winner_image = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw():
	draw_texture_rect(background_image, Rect2(Vector2(0,0), window), false) 
	if winner_image:
		var scaled_size = Vector2(winner_image.get_size().x * scale_factor, winner_image.get_size().y * scale_factor)
		var position = Vector2(window.x / 2 - scaled_size.x / 2, window.y / 2 - scaled_size.y / 2)
		draw_texture_rect(winner_image, Rect2(position, scaled_size), false) 

	draw_string(f, Vector2(window.x/2-150, window.y/2-80), ("Player " + str(Global.lastWinner) + " Won!"), HORIZONTAL_ALIGNMENT_CENTER, 300, 38, Color(0,0,0))
	
func _main_menu():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
