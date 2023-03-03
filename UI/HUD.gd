extends CanvasLayer

# Track 3 different sprites for the health bar
var bar_green = preload("res://assets/barHorizontal_green_mid 200.png")
var bar_yellow = preload("res://assets/barHorizontal_yellow_mid 200.png")
var bar_red = preload("res://assets/barHorizontal_red_mid 200.png")
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
	
	# Configure the smooth Tween feature to smoothly deplete the health bar to match new_value
	#$Margins/Container/HealthBar/Tween.interpolate_property($Margins/Container/HealthBar, 'value', $Margins/Container/HealthBa.value, new_value, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	# Start the animation
	#$Margins/Container/HealthBar/Tween.start()

	
	# Adjust healthbar to match current health
	$Margins/Container/HealthBar.value = new_value
