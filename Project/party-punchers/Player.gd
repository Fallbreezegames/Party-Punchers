extends CharacterBody2D

@export var speed = 150
@export var health = 100

@onready var hitbox = $Hitbox/CollisionShape2D
@onready var sprite = $Sprite2D

var current_anim = ""

var is_moving = true
var is_attacking = false

func _ready():
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

func update_facing(dir: int):
	# dir is 1 for right, -1 for left
	sprite.flip_h = dir == -1
	hitbox.position.x = abs(hitbox.position.x) * dir


func play_anim(anim_name):
	if current_anim != anim_name:
		$AnimationPlayer.play(anim_name)
		current_anim = anim_name

func _on_animation_finished(anim_name):
	if anim_name == "Light attack":
		is_attacking = false

func _process(_delta):
	var velocity = Vector2()

	# Handle attack input
	if Input.is_action_just_pressed("light_attack") and not is_attacking:
		is_attacking = true
		play_anim("Light attack")
		return

	# Skip movement and animation if attacking
	if is_attacking:
		return

	# Movement and animation logic when not attacking
	if is_moving:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed

		self.velocity = velocity
		move_and_slide()

		if velocity.length() > 0:
			play_anim("Walk")
			$Sprite2D.flip_h = velocity.x < 0
		else:
			play_anim("Idle")
