extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

const speed := 30
var dir = Vector2.RIGHT
var start_posit

var is_chatting := false

var player_in_chat_zone := false

func _ready() -> void:
	start_posit = position

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interagir") and player_in_chat_zone:
		$DialogueChatBox.start()
		is_chatting = true

func _on_chat_detection_area_area_entered(body) -> void:
	if body == player:
		player_in_chat_zone = true

func _on_chat_detection_area_area_exited(body) -> void:
	if body == player:
		player_in_chat_zone = false

func _on_dialogue_chat_box_dialogue_finished() -> void:
	is_chatting = false
