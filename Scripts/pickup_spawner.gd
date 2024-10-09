extends Node2D
class_name EnemySpawner

@export var bots: Array[PackedScene]

var pickup_scenes = [
	preload("res://scenes/health_pickup.tscn"),
	
]

var spawn_points = []
var occupied_spawn_points = []

func _ready():
	# Collect all spawn points
	for i in range(1, 11):  # From PickupSpawn1 to PickupSpawn25
		var spawn_point = get_node("PickupSpawn" + str(i))
		if spawn_point:
			spawn_points.append(spawn_point)
	
	print("Found ", spawn_points.size(), " spawn points")



func can_spawn_pickup() -> bool:
	var current_pickups = get_tree().get_nodes_in_group("Pickups").size()
	var max_pickups = 3
	return current_pickups < max_pickups and spawn_points.size() > occupied_spawn_points.size()

func spawn_pickup():
	var available_points = spawn_points.filter(func(point): return point not in occupied_spawn_points)
	if available_points.is_empty():
		print("No available spawn points")
		return

	var spawn_point = available_points[randi() % available_points.size()]
	var pickup_scene = pickup_scenes[randi() % pickup_scenes.size()]
	
	var pickup = pickup_scene.instantiate()
	pickup.position = spawn_point.global_position
	add_child(pickup)
	pickup.add_to_group("Pickups")
	
	occupied_spawn_points.append(spawn_point)
	
	# Connect to pickup's collection signal
	if pickup.has_signal("collected"):
		pickup.connect("collected", _on_pickup_collected.bind(spawn_point))
	
	print("Spawned ", pickup.name, " at ", spawn_point.name)

func _on_pickup_collected(spawn_point):
	occupied_spawn_points.erase(spawn_point)
	print("Freed spawn point: ", spawn_point.name)
	
		


func _on_timer_timeout() -> void:
	if can_spawn_pickup():
		spawn_pickup()
		print("SPAWNED PICKUP")
	print("try spawn")
