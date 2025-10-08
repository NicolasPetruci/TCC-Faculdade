extends CharacterBody2D
@export var gravity := 800.0
@export var jump_force := 350.0


@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	#gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_force
	
	if not is_on_floor():
		anim.play("Jumping")
	else:
		anim.play("Running")
	move_and_slide()
	
	
