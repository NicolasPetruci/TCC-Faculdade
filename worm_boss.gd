extends CharacterBody2D

var max_health := 550
@export  var health_boss := max_health

@onready var animation_player = $AnimationPlayer
@onready var health_bar = $CanvasLayer2/HealthBar

@onready var anim = $AnimatedSprite2D

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("idle")


func _on_player_body_entered(body: Node2D) -> void:
	animation_player.play("attack")


func _on_hitbox_body_entered(body: Node2D) -> void:
	body.take_damage(5)
	

#------------------------------------------------

func update_health_bar():
	if health_bar:
		health_bar.value = health_boss

func blink_effect():
	var blink_times = 4
	var blink_delay = 4 / (blink_times * 2)

	for i in range(blink_times):
		anim.visible = false
		await get_tree().create_timer(blink_delay).timeout
		anim.visible = true
		await get_tree().create_timer(blink_delay).timeout

func die():
	print("Boss morreu!")
	queue_free()

func take_damage(amount: int):
			health_boss -= amount
			print("Vida atual do Boss:", health_boss)
			update_health_bar()
			if health_boss <= 0:
				die()
			else:
				blink_effect()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		take_damage(10)
		
