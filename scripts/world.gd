extends Node2D
const player_scene = preload("res://scenes/player.tscn")

func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)
	
	# Spawn local player immediately
	_spawn_player(multiplayer.get_unique_id())

func _on_peer_connected(id):
	# Only host should handle this
	if multiplayer.is_server():
		_spawn_player(id)

func _spawn_player(peer_id: int):
	if player_scene == null:
		push_error("Player scene not set!")
		return

	var player = player_scene.instantiate()
	player.name = str(peer_id)
	player.set_multiplayer_authority(peer_id)
	add_child(player)
