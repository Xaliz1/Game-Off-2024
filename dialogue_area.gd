extends Area2D

@export var text_key: String = "space"
var area_active: bool = false

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		SignalBus.emit_signal("display_dialogue", text_key)
		print("tried to interact")


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
	area_active = true
	print("dialogue interact enter")

func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
	area_active = false
	print("dialogue interact exit")
