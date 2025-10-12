extends CharacterBody2D

var max_health := 550
var health := max_health

@onready var animation_player = $AnimationPlayer

@onready var anim = $AnimatedSprite2D

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("idle")


func _on_player_body_entered(body: Node2D) -> void:
	animation_player.play("attack")


func _on_hitbox_body_entered(body: Node2D) -> void:
	body.take_damage(5)
	

#------------------------------------------------

@export var max_health_boss := 200

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
			health -= amount
			print("Vida atual do Boss:", health)
			if health <= 0:
				die()
			else:
				blink_effect()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		take_damage(10)
