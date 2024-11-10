extends Control
func _ready():
	get_tree().paused = false


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/playground.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
