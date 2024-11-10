extends Panel




func _on_resume_pressed() -> void:
	self.hide()
	get_tree().paused = false
	


func _on_exit_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
