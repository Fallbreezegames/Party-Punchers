extends Node2D


func take_damage(amount: int) -> void:
	$AnimatedSprite2D.animation = "Hit"
	print("Damage: ", amount)
