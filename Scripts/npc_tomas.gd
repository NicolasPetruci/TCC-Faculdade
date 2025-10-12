extends Area2D

@onready var texto_interacao: Label = $TextoInteracao
@onready var caixa_de_dialogo: Label = $CanvasLayer/CaixaDeDialogo
@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo

var player_in_area := false
var falando := false
var pode_avancar := false
var fala_index := 0

var falas = [
	"Tomas: Rapaz, você realmente quebrou o vidro lá de trás.",
	"Gabriel: A ideia foi sua...",
	"Tomas: É... quem diria."
]

func _ready() -> void:
	caixa_de_dialogo.visible = false
	texto_dialogo.visible = false
	texto_interacao.visible = false

func _process(delta: float) -> void:
	if player_in_area and not falando and Input.is_action_just_pressed("Interagir"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("Interagir"):
		proxima_fala()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = true
		texto_interacao.text = "Pressione 'E' para interagir"
		texto_interacao.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_area = false
		texto_interacao.visible = false
		if falando:
			encerrar_dialogo()

func iniciar_dialogo():
	falando = true
	texto_interacao.visible = false
	caixa_de_dialogo.visible = true
	texto_dialogo.visible = true
	fala_index = 0
	proxima_fala()

func proxima_fala():
	if fala_index < falas.size():
		pode_avancar = false
		texto_dialogo.text = ""
		var texto = falas[fala_index]
		fala_index += 1
		mostrar_texto_com_efeito(texto)
	else:
		encerrar_dialogo()

func mostrar_texto_com_efeito(text: String):
	await get_tree().create_timer(0.1).timeout
	for letra in text:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.02).timeout
	pode_avancar = true

func encerrar_dialogo():
	falando = false
	pode_avancar = false
	caixa_de_dialogo.visible = false
	texto_dialogo.visible = false
