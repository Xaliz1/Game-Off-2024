extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set("is_on_ice", true)
		print("On the Ice. Slippery!")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set("is_on_ice", false)
		print("Off the Ice.")
