extends Node2D

var f: Font = load("res://Assets/Fonts/Jersey10-Regular.ttf")
var window = DisplayServer.window_get_size()
var background_scene = preload("res://Scenes/game.tscn")  # Preload your background scene
var options_button
var credits_button
var start_button
var end_button


func _setup_buttons():
	start_button = Button.new()
	start_button.text = "Start"
	start_button.set_size(Vector2(50, 10))
	start_button.set_position(Vector2(-25,-50))
	start_button.pressed.connect(self._start_game)
	add_child(start_button)
	
	options_button = Button.new()
	options_button.text = "Options"
	options_button.set_position(Vector2(-34.75,-15))
	options_button.set_size(Vector2(50, 10))
	options_button.pressed.connect(self._open_options)
	add_child(options_button)
	
	credits_button = Button.new()
	credits_button.text = "Credits"
	credits_button.set_position(Vector2(-32.5,20))
	credits_button.set_size(Vector2(50, 10))
	credits_button.pressed.connect(self._open_credits)
	add_child(credits_button)
	
	end_button = Button.new()
	end_button.text = "End"
	end_button.set_position(Vector2(-25,55))
	end_button.set_size(Vector2(50, 10))
	end_button.pressed.connect(self._end_game)
	add_child(end_button)
	
	
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if f == null:
		print("Font not loaded properly!")
	process_mode = Node.PROCESS_MODE_PAUSABLE
	var background = background_scene.instantiate()  # Create an instance of the background
	background.set_process(false) 
	background.set_physics_process(false) 
	add_child(background) 
	for child in background.get_children():
			if child is Node:  # Check if the child is a Node type
				child.set_process(false)  # Disable processing for the child
				child.set_physics_process(false)
	
	
	var overlay = ColorRect.new()  # Create a new ColorRect
	overlay.color = Color(0, 0, 0, 0.5)  # Set color with 50% transparency
	overlay.position = Vector2(-300, -300)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Ignore mouse events
	overlay.size = get_viewport().size
	add_child(overlay)
	_setup_buttons()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _start_game():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	

func _open_credits():
	print("credits")
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _open_options():
	print("options")
	get_tree().change_scene_to_file("res://Scenes/options.tscn")


func _end_game():
	get_tree().quit()
