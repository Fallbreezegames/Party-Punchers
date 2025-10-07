extends Node2D

@onready var hud = $HUD
@onready var player1 = $Player1
@onready var player2 = $Player2

func _ready():
	player1.connect("damaged", _on_player_damaged)
	player2.connect("damaged", _on_player_damaged)

func _on_player_damaged(player_id, new_health):
	hud.update_health(player_id, new_health)
