extends Node

@onready var evil_spirit: CharacterBody2D = $"../Evil_Spirit"
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"
@onready var candle: AnimatedSprite2D = $"../Table/Candle"



func _on_candle_puzzle_failed() -> void:
	canvas_modulate.show()
	evil_spirit.start_chasing()
	evil_spirit.start_timer()

func _on_evil_spirit_banished() -> void:
	evil_spirit.stop_chasing()
	canvas_modulate.hide()
