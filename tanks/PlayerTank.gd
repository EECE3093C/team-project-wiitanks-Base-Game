extends "res://tanks/Tank.gd"

# Only modify the controls function
func control(delta):
	# First, rotate the turret so it is always pointing at the mouse pointer
	$Turret.look_at(get_global_mouse_position())
	
	# Next, let's deal with player rotation
	var rot_dir = 0
	if Input.is_action_pressed("turn_right"):
		rot_dir += 1
	if Input.is_action_pressed("turn_left"):
		rot_dir -= 1
	# Apply rotation based on our rotation speed and which button was pressed
	rotation += rotation_speed * rot_dir * delta
	
	# Last, let's deal with player movement
	tank_velocity = Vector2() 
	# Use the velocity Vector to capture information about which way we are moving
	if Input.is_action_pressed("forward"):
		tank_velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("back"):
		tank_velocity = Vector2(-speed/2, 0).rotated(rotation) # Moving backwards is slower by 0.5
	
	if Input.is_action_pressed("click"):
		# Call the base Tank class' shoot() function
		shoot()
