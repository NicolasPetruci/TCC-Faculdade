extends Area2D

var offScreen_y := -300.0

func _physics_process(delta):
	position.y += GameManeger.obj_speed * delta
	
	if position.y < offScreen_y:
		queue_free()

var life := 100

func take_damage(amount):
	life -= amount
	print("Inimigo levou", amount, "de dano. Vida:", life)
	if life <= 0:
		queue_free()
