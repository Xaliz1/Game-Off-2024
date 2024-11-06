extends AnimatedSprite2D

@onready var evil_spirit: CharacterBody2D = $"../../Evil_Spirit"
@onready var interaction_area: Interaction_Area = $InteractionArea
@onready var point_light_2d: PointLight2D = $PointLight2D
signal puzzle_failed


func _ready() -> void:
	interaction_area.interact = Callable(self,"on_interact")

func on_interact():
	if animation.begins_with("unlit"):
		play("lit")
		point_light_2d.show()
		puzzle_failed.emit()
		await evil_spirit.Banished
		play("unlit")

func _on_evil_spirit_banished() -> void:
	pass # Replace with function body.
