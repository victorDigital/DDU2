extends Area2D

var pickup_effect = preload("res://scenes/pickup_death_effect.tscn")




func _on_body_entered(body: Node2D) -> void:
	print("health")
	if body.has_method("increase_health"):
		var pickup_effect_instance = pickup_effect.instantiate() as Node2D
		pickup_effect_instance.global_position = global_position
		get_parent().add_child(pickup_effect_instance)
		queue_free()
