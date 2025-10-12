extends Node2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

@export var mini_worm_node : PackedScene

func _on_timer_timeout() -> void:
	spawn()

func spawn():
	var minion_worm = mini_worm_node.instantiate()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x = rng.randf_range(player.position.x + 25, player.position.x - 25);
	var y = rng.randf_range(player.position.y + 25, player.position.y - 25);
	minion_worm.position = Vector2(x, y)
	get_tree().current_scene.call_deferred("add_child", minion_worm)
