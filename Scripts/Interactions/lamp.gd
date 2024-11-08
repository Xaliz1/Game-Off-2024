extends AnimatedSprite2D

@onready var interaction_area: Interaction_Area = $InteractionArea
@onready var point_light_2d: PointLight2D = $PointLight2D
signal turned_on  # Signal emitted when this lamp is turned on

func _ready() -> void:
	interaction_area.interact = Callable(self, "on_interact")
	
func _process(delta: float) -> void:

	if animation.begins_with("lit"):
		interaction_area.monitoring = false
	else:
		interaction_area.monitoring = true

func on_interact():
	if animation.begins_with("unlit"):
		play("lit")
		point_light_2d.show()
		turned_on.emit(self)

func reset():
	point_light_2d.color = Color(0.758, 0.01, 0.037)
	point_light_2d.energy = 1
	await get_tree().create_timer(10).timeout
	point_light_2d.hide()
	point_light_2d.color = Color(0.976, 0.945, 0.412)
	play("unlit")
