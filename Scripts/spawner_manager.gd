extends Node2D

const TREE = preload("res://Scenes/tree.tscn")
const CAR = preload("res://Scenes/car.tscn")
const OBSTACLE = preload("res://Scenes/obstacle.tscn")

const GROUND_MIN_X = 20
const GROUND_MAX_X = 310

func spawn_object():
	var random_number = randi() % 100
	var packed : PackedScene
	
	if random_number < 25:
		packed = TREE
	elif random_number < 75:
		packed = CAR
	elif random_number < 100: 
		packed = OBSTACLE
	else :
		packed = null
		
	var inst = packed.instantiate()
	
	inst.position.x = get_viewport_rect().size.x + 20
	
	if packed == CAR:
		inst.position.x = randf_range(GROUND_MIN_X, GROUND_MAX_X)
	elif packed == TREE:
		inst.position.x = randf_range(GROUND_MIN_X, GROUND_MAX_X)
	elif packed == OBSTACLE:
		inst.position.x = randf_range(GROUND_MIN_X, GROUND_MAX_X)
	else:
		inst.position.x = randf_range(GROUND_MIN_X, GROUND_MAX_X)
	
	get_parent().add_child(inst)

func _on_spawn_time_timeout():
	spawn_object()
