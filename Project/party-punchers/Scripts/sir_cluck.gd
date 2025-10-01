extends CharacterBody2D

@export var speed = 150  # How fast the player will move (pixels/sec)
var is_moving = true  # To handle the movement
@export var health = 100  # For health
@export var mana = 100  # For mana

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if is_moving:
		var velocity = Vector2()  # Reset velocity every frame

		# Capture input for movement
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1

		# Normalize the velocity to avoid faster diagonal movement
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed

		# Apply the velocity to the character's built-in velocity and move
		self.velocity = velocity  # Set the velocity for the CharacterBody2D
		move_and_slide()

		# Update animation based on velocity
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "Walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "Walk"
		else:
			$AnimatedSprite2D.animation = "Idle"
