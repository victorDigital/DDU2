extends Area2D


@export var speed = 250
@export var targetGroup: StringName 


func start(pos):
	position = pos

func _process(delta):
	position += Vector2(speed * delta, 0).rotated(rotation)
