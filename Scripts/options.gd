extends Node2D
var sound_button
var menu_button
var window: Vector2 = DisplayServer.window_get_size()
var f: Font = load("res://Assets/Fonts/Jersey10-Regular.ttf")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.bbcode_enabled = true
	$RichTextLabel.bbcode_text = "[color=black]Options[/color]"
	$RichTextLabel.set_position(Vector2(window.x/2-80, 80))
	$muted_text.bbcode_enabled = true
	$muted_text.bbcode_text = "[color=black]Sound is muted[/color]"
	$muted_text.set_position(Vector2(window.x/2-80, 250))
	setupSoundButton()
	setupMenuButton()
	queue_redraw()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	window = DisplayServer.window_get_size()
	$ColorRect.size = window
	if AudioManager.audio_muted == true:
		$muted_text.visible = true
	else: 
		$muted_text.visible = false



		
	

func setupSoundButton():
	sound_button = Button.new()
	sound_button.text = "Click to toggle sound"
	sound_button.set_size(Vector2(150, 50))
	sound_button.set_position(Vector2(window.x/2-75,200))
	#button.pressed.connect(AudioManager.toggle_audio())
	sound_button.pressed.connect(Callable(AudioManager, "toggle_audio"))
	add_child(sound_button)
	
	
func setupMenuButton():
	menu_button = Button.new()
	menu_button.text = "Click to proceed to Menu"
	menu_button.set_size(Vector2(150, 50))
	menu_button.set_position(Vector2(window.x/2-75,400))
	menu_button.pressed.connect(Callable(self, "_menu"))
	add_child(menu_button)

func _menu():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
