extends StaticBody2D

const FALL_THROUGH_TIME = 0.5

# Dictionary to keep track of players who are falling through
var falling_players = {}

func _ready():
	# Make sure collision layer and mask are set up correctly
	set_collision_layer_value(1, true)  # Layer 1 for platforms
	set_collision_mask_value(1, true)   # Respond to player collision

func _process(_delta):
	# Check each falling player
	for player_id in falling_players.keys():
		if falling_players[player_id] <= 0:
			falling_players.erase(player_id)

	# Update collision exception for each player
	for player in get_tree().get_nodes_in_group("players"):
		if falling_players.has(player.name):
			# Disable collision with this player
			add_collision_exception_with(player)
		else:
			# Enable collision with this player
			remove_collision_exception_with(player)

	# Decrement timers
	for player_id in falling_players.keys():
		falling_players[player_id] -= _delta

# Called when a player wants to fall through
func initiate_fall_through(player):
	falling_players[player.name] = FALL_THROUGH_TIME
