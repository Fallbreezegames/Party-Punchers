extends CharacterBody2D

@export var speed = 150
@export var health = 100

var is_moving = true
var is_attacking = false

func _process(_delta):
	var velocity = Vector2()

	# Handle attack input first
	if Input.is_action_just_pressed("light_attack") and not is_attacking:
		is_attacking = true
		$AnimationPlayer.play("Attack")

	# If attacking, don't change animation until finished
	if is_attacking:
		# Optionally, allow movement during attack
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		self.velocity = velocity
		move_and_slide()
		return  # Skip further animation logic

	# Movement and animation logic when not attacking
	if is_moving:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.flip_v= false

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed

		self.velocity = velocity
		move_and_slide()


func _on_animation_finished(Attack):
	if Attack == "Attack":
		is_attacking = false
		$AnimationPlayer.play("Idle")
