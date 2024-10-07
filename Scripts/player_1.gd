extends CharacterBody2D


@export var MAX_HEALTH = 100
var health
signal p1_health_changed(new_health)
signal player_dead(player)



const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var canshoot =true

@onready var animated_sprite = $AnimatedSprite2D
@onready var shoot_cooldown: Timer = $ShootCooldown
var shoot_offset: Vector2
const BULLET = preload("res://Scenes/bullet.tscn")
var player_look = 1
var knockback := Vector2.ZERO


func _ready():
	add_to_group("players")
	health = MAX_HEALTH
	emit_signal("p1_health_changed", health)

	
func increase_health(amount: int):
	health += amount


func take_damage(dmg: int):
	if health <= 0:
		_player_dead()
	else:
		health -= dmg

	
		

func _physics_process(delta: float) -> void:
	emit_signal("p1_health_changed", health)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta*1.5
		
	# Handle jump.
	if Input.is_action_just_pressed("player1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player1_left", "player1_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	velocity.x += knockback.x
	
	if direction < 0:
		player_look = 0
		$AnimatedSprite2D.flip_h = true
	if direction > 0:
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
	if Input.is_action_pressed("player1s"):
		if canshoot:
			canshoot = false
			shoot_cooldown.start()
			var shoot_position
			if player_look == 1:
				shoot_position = 0
				knockback.x = -200

			if player_look == 0:
				shoot_position = -PI
				knockback.x = 200

			var bullet = BULLET.instantiate()
			bullet.position = global_position + Vector2(20 * cos(shoot_position), 20 * sin(shoot_position))
			bullet.rotate(shoot_position)
			get_tree().root.add_child(bullet)
		

func _player_dead():
	emit_signal("player_dead", 1)
	queue_free()


func _on_shoot_cooldown_timeout() -> void:
	canshoot = true
	
