extends Node2D

func _physics_process(delta):
	if GameManeger.obj_speed < GameManeger.max_obj_speed:
		GameManeger.obj_speed += GameManeger.obj_acceleration * delta
	if GameManeger.world_speed < GameManeger.max_world_speed:
		GameManeger.world_speed += GameManeger.world_acceleration * delta
