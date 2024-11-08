extends Button




func _on_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	InteractionManager.can_interact = true
	pass # Replace with function body.
