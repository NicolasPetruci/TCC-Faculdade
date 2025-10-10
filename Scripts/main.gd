extends Node2D

var count := 30.0
@onready var label_count = $CanvasLayer/LabelTimer

@export var main2 := "res://Scenes/bus_level.tscn"

func _process(delta):
	count -= delta * 1
	label_count.text = "Temporizador: " + str(int(count))
	if count <= 0:
		get_tree().change_scene_to_file(main2)


func _physics_process(delta:):
	if GameManeger.obj_speed < GameManeger.max_obj_speed:
		GameManeger.obj_speed += GameManeger.obj_acceleration * delta
	if GameManeger.world_speed < GameManeger.max_world_speed:
		GameManeger.world_speed += GameManeger.world_acceleration * delta
