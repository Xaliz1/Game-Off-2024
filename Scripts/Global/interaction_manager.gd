extends Node2D


@onready var player = get_tree().get_first_node_in_group("player")
@onready var label: Label = $Label

const base_text : String = "[E] to "

var active_areas : Array = []
var can_interact : bool = true


func register_area(area : Interaction_Area):
	active_areas.push_back(area)

func unregister_area(area: Interaction_Area):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if active_areas.size() >0 && can_interact:
		active_areas.sort_custom(sort_by_distance_to_player)
		label.text = base_text + active_areas[0].interaction_name
		label.position = active_areas[0].global_position
		label.position.y -= 36
		label.position.x -= label.size.x /2
		label.show()
	else:
		label.hide()

func sort_by_distance_to_player(area1,area2):
	var area1_to_player = player.global_position.distance_to(area1.globalposition)
	var area2_to_player = player.global_position.distance_to(area2.globalposition)
	return area1_to_player < area2_to_player

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") && can_interact:
		if active_areas.size() >0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true