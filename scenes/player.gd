extends CharacterBody2D

var score = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Animations
const ANIMATION_MOVE = "move"
const ANIMATION_JUMP = "jump"
var LAST_DIRECTION = 0


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		print(velocity.y, "|", gravity, "|", delta)
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimatedSprite2D.animation = ANIMATION_JUMP
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		LAST_DIRECTION = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Moving Animation
	if velocity.length() > 0:
		
		if is_on_floor():
			$AnimatedSprite2D.animation = ANIMATION_MOVE
			velocity = velocity.normalized() * SPEED
			# Flip Sprite Horizontal (WALK/MOVE)
			if velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
		else:
			$AnimatedSprite2D.animation = ANIMATION_JUMP
			#velocity = velocity.normalized() * SPEED (REPLACE with Y logic)[JumpHeight]
			# Flip Sprite Horizontal (JUMP)
			if LAST_DIRECTION < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	move_and_slide()
	

func _on_tile_broken(N):
	score += N
	print("Score: ", score)
