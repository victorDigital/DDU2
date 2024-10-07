extends Camera2D

@export var player1: CharacterBody2D;
@export var player2: CharacterBody2D;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if the player1 is null or player2 is null, return
	if player1 == null or player2 == null:
		return

	# set the camera position to the average of the two players
	position = lerp(position,(player1.position + player2.position) / 2, 0.02)

	# set the camera zoom to the distance between the two players
	var mult = 1.0
	mult = 1/((player1.position - player2.position) / 5).length() * 100

	if mult > 3:
		mult = 3

	if mult < 1.5:
		mult = 1.5
	



	
	print(mult)
	zoom = lerp(zoom,Vector2(mult, mult), 0.01)
