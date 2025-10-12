extends Node2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

@export var mini_worm_node : PackedScene

func _on_timer_timeout() -> void:
	spawn()

func spawn():
	var minion_worm = mini_worm_node.instantiate()
	minion_worm.position = player.position
	get_tree().current_scene.call_deferred("add_child", minion_worm)
