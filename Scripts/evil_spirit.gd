extends CharacterBody2D

const MOVE_SPEED = 80
signal Banished

@onready var hurtbox: CollisionShape2D = $Hurtbox/Hurtbox
@onready var timer: Timer = $Timer
@onready var player: Node2D = $"../player"
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var is_visible = false

func _physics_process(delta: float) -> void:
	if is_visible and player:
		InteractionManager.can_interact = false
		update_path_to_player()
		follow_path(delta)
	else:
		velocity = Vector2.ZERO

	collision_shape_2d.disabled = not is_visible
	hurtbox.disabled = not is_visible

func update_path_to_player() -> void:
	nav_agent.target_position = player.global_position

func follow_path(delta: float) -> void:
	if not nav_agent.is_navigation_finished():
		var direction = (nav_agent.get_next_path_position() - global_position).normalized()
		velocity = direction * MOVE_SPEED
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _on_timer_timeout() -> void:
	emit_signal("Banished")
	print("Banished!")

func start_timer():
	timer.start()

func start_chasing():
	is_visible = true
	show()
	update_path_to_player()

func stop_chasing():
	is_visible = false
	hide()
	velocity = Vector2.ZERO

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.gameover()
