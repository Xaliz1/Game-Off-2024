extends AnimatedSprite2D

@onready var interaction_area: Interaction_Area = $InteractionArea
@onready var point_light_2d: PointLight2D = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self,"on_interact")

func on_interact():
	if animation.begins_with("unlit"):
		play("lit")
		point_light_2d.show()
	else:
		play("unlit")
		point_light_2d.hide()
