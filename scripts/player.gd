extends CharacterBody2D

func _enter_tree():
	set_multiplayer_authority(name.to_int())  # makes sure each peer controls its player

func _physics_process(delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 400
	move_and_slide()
