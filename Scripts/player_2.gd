extends CharacterBody2D



const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var canshoot =true

@onready var animated_sprite = $AnimatedSprite2D
@onready var shoot_cooldown: Timer = $ShootCooldown
var shoot_offset: Vector2
const BULLET = preload("res://Scenes/bullet.tscn")
var player_look = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta*1.5

	# Handle jump.
	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player2_left", "player2_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x < 0:
		player_look = 0
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		player_look = 1
		$AnimatedSprite2D.flip_h = false
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("fall")
		else:
			animated_sprite.play("jump")
	
	move_and_slide()
	if Input.is_action_pressed("player2s"):
		if canshoot:
			canshoot = false
			shoot_cooldown.start()
			var shoot_position
			if player_look == 1:
				shoot_position = 0
			if player_look == 0:
				shoot_position = -PI
			var bullet = BULLET.instantiate()
			bullet.position = global_position
			bullet.rotate(shoot_position)
			get_tree().root.add_child(bullet)




func _on_shoot_cooldown_timeout() -> void:
	canshoot = true
