extends Node2D

# At the beginning of loading a level, set the camera so it doesnt scroll past the edges of the map
func _ready():
	set_camera_limits()
	# Set our crosshair.png file to the mouse cursor
	Input.set_custom_mouse_cursor(load("res://assets/UI Elements/crossair_black.png"), Input.CURSOR_ARROW, Vector2(16,16))
	
func set_camera_limits():
	# First, get the size of the map and the tile size
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_quadrant_size
	# Calculate camera limits based on map bounds and tile size
	$PlayerTank/Camera2D.limit_left = map_limits.position.x * map_cellsize
	$PlayerTank/Camera2D.limit_right = map_limits.end.x * map_cellsize
	$PlayerTank/Camera2D.limit_top = map_limits.position.y * map_cellsize
	$PlayerTank/Camera2D.limit_bottom = map_limits.end.y * map_cellsize


# All tank shooting will be managed here
func _on_Tank_shoot(bullet, _position, _direction):
	# Create new instance of the bullet prefab
	var b = bullet.instantiate()
	# Attach the bullet to the scene
	add_child(b)
	# Call the bullet's start function
	b.start(_position,_direction)


func _on_PlayerTank_dead():
	# If the player dies, reload the scene
	get_tree().reload_current_scene()
