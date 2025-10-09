extends CharacterBody2D

@export var speed := 200.0
@export var dash_speed := 600.0
@export var dash_time := 0.1
@export var dash_cooldown := 3.0

@onready var anim = $AnimatedSprite2D
@onready var dash_timer_node = $DashTimer  # o nó precisa se chamar "DashTimer" no editor

var is_dashing := false
var dash_timer := 0.0
var can_dash := true
var direction := Vector2.ZERO


func _physics_process(delta):
	var input_dir = Vector2.ZERO
	
	# Movimento normal
	if Input.is_action_pressed("Direita"):
		input_dir.x += 1
	if Input.is_action_pressed("Esquerda"):
		input_dir.x -= 1
	if Input.is_action_pressed("Baixo"):
		input_dir.y += 1
	if Input.is_action_pressed("Cima"):
		input_dir.y -= 1

	input_dir = input_dir.normalized()

	# Atualiza direção para dash
	if input_dir != Vector2.ZERO:
		direction = input_dir

	# Inicia dash
	if Input.is_action_just_pressed("Dash") and can_dash and direction != Vector2.ZERO:
		start_dash()

	# Executa dash
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			stop_dash()
		else:
			velocity = direction * dash_speed
	else:
		velocity = input_dir * speed

	move_and_slide()

	# Animações
	if is_dashing:
		anim.play("Dash")
	elif input_dir != Vector2.ZERO:
		anim.play("Running")
		anim.flip_h = input_dir.x < 0
	else:
		anim.play("Idle")


func start_dash():
	is_dashing = true
	can_dash = false
	dash_timer = dash_time
	anim.play("Dash")
	dash_timer_node.start(dash_cooldown)


func stop_dash():
	is_dashing = false


func _on_DashTimer_timeout():
	can_dash = true
