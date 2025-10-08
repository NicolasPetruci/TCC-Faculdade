extends Area2D

var offScreen_y := -180.0

func _physics_process(delta):
	position.y += GameManeger.obj_speed * delta
	
	if position.y < offScreen_y:
		queue_free()
