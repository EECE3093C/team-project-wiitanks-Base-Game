extends Node2D

# Track 3 different sprites for the health bar
var bar_green = preload("res://assets/barHorizontal_green_mid 200.png")
var bar_yellow = preload("res://assets/barHorizontal_yellow_mid 200.png")
var bar_red = preload("res://assets/barHorizontal_red_mid 200.png")
var bar_texture

func _ready():
	# Hide all children of this Node2D obj on start
	for node in get_children():
		node.hide()

func _process(delta):
	# Always show unit display above the tank, not rotating with the tank
	global_rotation = 0

func update_healthbar(new_value):
	# Check which color the healthbar should be
	if new_value > 50:
		bar_texture = bar_green
	elif new_value > 20:
		bar_texture = bar_yellow
	else:
		bar_texture = bar_red
	# Assign health bar a value and color based on new_value.
	$HealthBar.texture_progress = bar_texture
	$HealthBar.value = new_value
	# Only show the healthbar if not at 100%
	if new_value < 100:
		$HealthBar.show()

