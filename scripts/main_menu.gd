extends Control

@onready var line_edit: LineEdit = $VBoxContainer/LineEdit

var peer = ENetMultiplayerPeer.new()

const world_scene = preload("res://scenes/world.tscn")

func _on_host_pressed() -> void:
	print("Hosting...")
	var err = peer.create_server(135)
	if err != OK:
		push_error("Failed to host server!")
		return

	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_packed(world_scene)

func _on_join_pressed() -> void:
	print("Joining...")
	var ip = line_edit.text.strip_edges()
	if ip.is_empty():
		push_error("Enter a valid IP address.")
		return

	var err = peer.create_client(ip, 135)
	if err != OK:
		push_error("Failed to join server!")
		return

	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_packed(world_scene)
