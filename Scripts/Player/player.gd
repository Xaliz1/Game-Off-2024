extends CharacterBody2D


const movement_speed = 120
var move_direction = Vector2.ZERO
var desired_velocity = Vector2.ZERO
@onready var game_over: Panel = $Game_over
@onready var pause: Panel = $Pause



func _physics_process(delta: float) -> void:
	player_input()
	apply_movement()


func player_input():
	move_direction = Vector2.ZERO
	# Adjust move direction based on input actions.
	# Horizontal movement: subtract 1 if 'Left' is pressed, add 1 if 'Right' is pressed.
	move_direction.x = -int(Input.is_action_pressed("Left")) + int(Input.is_action_pressed("Right"))
	# Vertical movement: subtract 1 if 'Up' is pressed, add 1 if 'Down' is pressed.
	move_direction.y = -int(Input.is_action_pressed("Up")) + int(Input.is_action_pressed("Down"))
	# Normalize the move direction to avoid faster diagonal movement and apply speed.
	desired_velocity = move_direction.normalized() * movement_speed

func apply_movement():
	# Smoothly transition to desired velocity over time (lerp factor 0.1).
	velocity = desired_velocity.lerp(desired_velocity, .1)
	move_and_slide()

func gameover():
	game_over.show()
	get_tree().paused = true
	pass

func _input(event):
	if event.is_action_pressed("Pause"):
		get_tree().paused = true
		pause.show()
		pass
		
