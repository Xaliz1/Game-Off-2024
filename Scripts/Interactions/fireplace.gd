extends AnimatedSprite2D

@onready var interaction_area: Interaction_Area = $InteractionArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"on_interact")


func on_interact():
	if animation.begins_with("unlit"):
		play("lit")
	else:
		play("unlit")
