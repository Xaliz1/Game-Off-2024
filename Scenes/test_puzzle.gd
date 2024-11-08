extends Node2D

@onready var lamp_1: AnimatedSprite2D = $Lamp1
@onready var lamp_2: AnimatedSprite2D = $Lamp2
@onready var lamp_3: AnimatedSprite2D = $Lamp3
@onready var lamp_4: AnimatedSprite2D = $Lamp4
@onready var lamp_5: AnimatedSprite2D = $Lamp5

signal puzzle_failed
var lamps = []
@onready var correct_order = [lamp_2, lamp_4, lamp_3, lamp_5, lamp_1]
var player_order = []

func _ready() -> void:
	lamps = [lamp_1, lamp_2, lamp_3, lamp_4, lamp_5]
	print(correct_order)
	for lamp in lamps:
		lamp.turned_on.connect(_on_lamp_turned_on)

func _on_lamp_turned_on(lamp: AnimatedSprite2D) -> void:
	if lamp == correct_order[player_order.size()]:
		print("Lamp Turned On: ", lamp)
		print("Expected Lamp: ", correct_order[player_order.size()])
		player_order.append(lamp)
		if player_order.size() == correct_order.size():
			_on_puzzle_solved()
	else:
		print("Lamp Turned On: ", lamp)
		print("Expected Lamp: ", correct_order[player_order.size()])
		_reset_sequence()
		
func _on_puzzle_solved() -> void:
	print("Puzzle Solved!")
	

func _reset_sequence() -> void:
	print("Incorrect sequence, resetting.")
	player_order.clear()
	puzzle_failed.emit()
	for lamp in lamps:
		lamp.reset()
		
