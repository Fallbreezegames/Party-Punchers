extends Node2D

@export var max_health := 100
var health := max_health

@export var player_id := 2  # or , etc.

signal damaged(player_id: int, new_health: float)

func take_damage(amount: float):
	health = clamp(health - amount, 0, max_health)
	$AnimatedSprite2D.animation = "Hit"
	emit_signal("damaged", player_id, health)
	print("Player", player_id, "took", amount, "damage, now at", health)
