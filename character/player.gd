extends CharacterBody2D

@export var camera_limit_right := 4500.0
@export var speed = 150.0
var screen_size
@export var can_move = true
func _ready():
	screen_size = get_viewport_rect().size

	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if not can_move:
		return
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$sprite.play()
	else:
		$sprite.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$sprite.animation = "walk"
		$sprite.flip_v = false
		# See the note below about the following boolean assignment.
		$sprite.flip_h = velocity.x < 0
	
