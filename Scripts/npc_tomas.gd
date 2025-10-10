extends Area2D

@onready var texto_interacao: Label = $TextoInteracao
@onready var caixa_de_dialogo: Label = $CanvasLayer/CaixaDeDialogo



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
