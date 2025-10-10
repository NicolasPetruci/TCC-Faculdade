extends Control

signal dialogue_finished

@export_file("*.json") var dialogue_file_path: String

var dialogue = []
var current_dialogue_id = 0
var dialogue_active := false

func _ready() -> void:
	$NinePatchRect.visible = false
	
	if dialogue_file_path.is_empty():
		push_error("DialogueChatBox: A propriedade 'dialogue_file_path' não está definida!")

func start():
	
	if dialogue_active:
		return
	dialogue_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var file = FileAccess.open(dialogue_file_path, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event: InputEvent) -> void:
	if !dialogue_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		$NinePatchRect.visible = false
		dialogue_finished.emit()
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']
