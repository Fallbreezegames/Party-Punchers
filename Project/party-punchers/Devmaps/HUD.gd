extends CanvasLayer

@onready var p1_percent_label = $Control/Player1UI/PercentLabel
@onready var p2_percent_label = $Control/Player2UI/PercentLabel

var p1_percent := 0
var p2_percent := 0
var smash_mode := false  # toggle between HP and % later
var max_health := 100.0

func update_health(player_id: int, new_health: float):
	if smash_mode:
		# Smash percent mode (damage goes up)
		# You’ll handle this later when you add the percent tracking
		pass
	else:
		# Classic health mode
		var percent = int((new_health / max_health) * 100)
		if player_id == 1:
			p1_percent_label.text = "HP: %d%%" % percent
		else:
			p2_percent_label.text = "HP: %d%%" % percent


func update_percent(player: int, amount: float):
	if player == 1:
		p1_percent = clamp(p1_percent + amount, 0, 999)
		p1_percent_label.text = str(int(p1_percent))
		p1_percent_label.add_theme_color_override("font_color", get_percent_color(p1_percent))
	else:
		p2_percent = clamp(p2_percent + amount, 0, 999)
		p2_percent_label.text = str(int(p2_percent))
		p2_percent_label.add_theme_color_override("font_color", get_percent_color(p2_percent))

func get_percent_color(value: float) -> Color:
	# smoothly fade from white → yellow → red like Smash
	if value < 50:
		return Color(1, 1, 1) # white
	elif value < 100:
		return Color(1, 1, 0) # yellow
	else:
		return Color(1, 0.3, 0.3) # red
