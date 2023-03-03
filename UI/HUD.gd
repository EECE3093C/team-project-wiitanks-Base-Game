extends CanvasLayer

# Track 3 different sprites for the health bar
var bar_green = preload("res://assets/UI Elements/barHorizontal_green_mid 200.png")
var bar_yellow = preload("res://assets/UI Elements/barHorizontal_yellow_mid 200.png")
var bar_red = preload("res://assets/UI Elements/barHorizontal_red_mid 200.png")
var bar_texture

# Connects to PlayerTank health_changed emit
func update_health(new_value):
	# Check which color the healthbar should be
	if new_value > 50:
		bar_texture = bar_green
	elif new_value > 20:
		bar_texture = bar_yellow
	else:
		bar_texture = bar_red
		
	# Update healthbar color to match current health
	$Margins/Container/HealthBar.texture_progress = bar_texture
	
	# Adjust healthbar to match current health
	$Margins/Container/HealthBar.value = new_value
