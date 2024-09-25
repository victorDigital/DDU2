extends Area2D


@export var speed = 250
@export var targetGroup: StringName 
var bullet_dmg = 10

func _ready():
	connect("body_entered", Callable(self, "_on_Bullet_body_entered"))
	

func start(pos):
	position = pos

func _process(delta):
	position += Vector2(speed * delta, 0).rotated(rotation)
# Function triggered when the bullet collides with another body

func _on_Bullet_body_entered(body):
	# Add logic here if you want to check what was hit, e.g.:
	if body.is_in_group("players"):
		body.take_damage(bullet_dmg)
	queue_free() 
