extends CharacterBody2D

var score = 0
@export var SPEED = 300.0
@export var JUMP_FORCE = -500.0
@onready var coyote_timer = $CoyoteTimer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Animations
const ANIMATION_MOVE = "move"
const ANIMATION_JUMP = "jump"
var LAST_DIRECTION = 0

var sayan = false

var throw = false
var mirror = 1

func _thrown(x):
	throw = true
	if x < 0:
		mirror = -1
	else:
		mirror = 1
var coyote_time = 0.1
var is_jumping = false

func _ready():
	coyote_timer.start()

func _physics_process(delta):
	
	if Input.is_action_just_pressed('sayan'):
		print('sayan')
		if !sayan:
			SPEED = 750
			JUMP_FORCE = -750
			sayan=true
		else:
			SPEED = 300
			JUMP_FORCE = -500
			sayan=false

	# Add the gravity (y)
	if not is_on_floor():
		velocity.y += gravity * delta
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote_timer.is_stopped() == false):
		$AnimatedSprite2D.animation = ANIMATION_JUMP
		velocity.y = JUMP_FORCE
		is_jumping = true
		$AnimatedSprite2D.play()
	
	if is_on_floor():
		is_jumping = false
		coyote_timer.start()
		
	# Check player lands on the floor
	if is_on_floor() and coyote_timer.is_stopped():
		coyote_timer.start()

	# Get the input direction and handle the movement
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		LAST_DIRECTION = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Animation
	if is_on_floor():
		if throw && direction == 0:
			direction = mirror
			throw = false
			LAST_DIRECTION = mirror
		if direction != 0:
			$AnimatedSprite2D.animation = ANIMATION_MOVE
			$AnimatedSprite2D.flip_h = direction < 0
		else:
			$AnimatedSprite2D.stop()
	else:
		if throw && Input.get_axis("ui_left", "ui_right") == 0:
			LAST_DIRECTION= mirror
			throw = false
		$AnimatedSprite2D.animation = ANIMATION_JUMP
		$AnimatedSprite2D.flip_h = LAST_DIRECTION < 0

	$AnimatedSprite2D.play()

	move_and_slide()
	
func _on_tile_broken(key):
	score += 10
	#print("Score: ", score)
