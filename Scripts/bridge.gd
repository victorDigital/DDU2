extends StaticBody2D

@onready var collision = $CollisionShape2D
@onready var area = $Area2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player1_down") || event.is_action_pressed("player2_down"):
		area.set_deferred("monitoring", true)

func _on_area_2d_body_entered(body: Node) -> void:
	collision.set_deferred("disabled", true)



func _on_area_2d_body_exited(body: Node) -> void:
	collision.set_deferred("disabled", false)
	area.set_deferred("monitoring", false)
