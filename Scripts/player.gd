extends CharacterBody2D

@export var speed := 200.0
@export var dash_speed := 600.0
@export var dash_time := 0.1
@export var dash_cooldown := 3.0
@export var max_health := 30
@export var invincible_time := 1.0

@onready var anim = $AnimatedSprite2D
@onready var dash_timer_node = $DashTimer
@onready var invincible_timer = $InvincibleTimer  

var attackScn: PackedScene = preload("res://Scenes/player_attack.tscn")

@export var player_in_area := false
var is_dashing := false
var dash_timer := 0.0
var can_dash := true
var direction := Vector2.ZERO
var non_normal_dir := Vector2.ZERO
var health := max_health
var is_invincible := false


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
	non_normal_dir = input_dir
	input_dir = input_dir.normalized()

	if input_dir != Vector2.ZERO:
		direction = input_dir

	if Input.is_action_just_pressed("Dash") and can_dash and direction != Vector2.ZERO:
		start_dash()

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

func _input(event):
	if event.is_action_released("Atacar"):
		attack()

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



func _on_area_2d_area_entered(area):
	if area.is_in_group("dangerous"):
		take_damage(1)


func take_damage(amount: int):
	if is_invincible:
		return

	health -= amount
	is_invincible = true
	invincible_timer.start(invincible_time)
	
	print("Vida atual do Player:", health)

	if health <= 0:
		die()
	else:
		# Pisca pra indicar dano
		blink_effect()


func _on_InvincibleTimer_timeout():
	is_invincible = false


func die():
	print("Personagem morreu!")
	queue_free()
	get_tree().reload_current_scene()


func blink_effect():
	var blink_times = 4
	var blink_delay = invincible_time / (blink_times * 2)

	for i in range(blink_times):
		anim.visible = false
		await get_tree().create_timer(blink_delay).timeout
		anim.visible = true
		await get_tree().create_timer(blink_delay).timeout

func attack():
	var atk: Node2D = attackScn.instantiate()
	add_child(atk)
	atk.attack(non_normal_dir)

func _on_InvencibleTimer_timeout() -> void:
	is_invincible = false
