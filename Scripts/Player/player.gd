extends CharacterBody2D

const movement_speed = 120
var move_direction = Vector2.ZERO
var desired_velocity = Vector2.ZERO
var is_on_ice = false  # Track if the player is on ice
var has_collided = true
@onready var game_over: Panel = $Game_over
@onready var pause: Panel = $Pause

func _physics_process(delta: float) -> void:
	player_input()
	apply_movement(delta)

func player_input():
	# Reset movement direction
	if has_collided or !is_on_ice:
		move_direction = Vector2.ZERO
	
	# If the player is not on ice, directly control movement
		if !is_on_ice:
			move_direction.x = -int(Input.is_action_pressed("Left")) + int(Input.is_action_pressed("Right"))
			move_direction.y = -int(Input.is_action_pressed("Up")) + int(Input.is_action_pressed("Down"))
			desired_velocity = move_direction.normalized() * movement_speed
		else:
			# On ice, maintain current velocity unless new input is detected
			if Input.is_action_pressed("Left") or Input.is_action_pressed("Right") or Input.is_action_pressed("Up") or Input.is_action_pressed("Down") and has_collided:
				move_direction.x = -int(Input.is_action_pressed("Left")) + int(Input.is_action_pressed("Right"))
				move_direction.y = -int(Input.is_action_pressed("Up")) + int(Input.is_action_pressed("Down"))
				desired_velocity = move_direction.normalized() * movement_speed
				velocity = desired_velocity  # Set initial sliding direction
				has_collided = false
func apply_movement(delta: float):
	# If on ice, apply frictional slowdown
	if is_on_ice:
		velocity = velocity.move_toward(Vector2.ZERO, 5 * delta)
	else:
		# Directly set velocity to desired velocity when not on ice
		velocity = desired_velocity

	# Move and detect collisions
	var collision = move_and_collide(velocity * delta)
	
	# If colliding with a wall, stop velocity
	if collision:
		velocity = Vector2.ZERO
		has_collided = true
func gameover():
	game_over.show()
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("Pause"):
		get_tree().paused = true
		pause.show()
