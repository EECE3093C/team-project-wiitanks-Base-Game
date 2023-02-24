extends "res://tanks/Tank.gd"

onready var parent = get_parent()

export (float) var turret_speed
export (int) var detection_radius

var target = null

# Override control function to have tank follow a path
func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		# Always have position 0,0 relative to parent so we don't go off the path 
		position = Vector2()
	else:
		# Other movement code if not doing path following
		pass

func _ready():
	var circle_collision = CircleShape2D.new()
	$DetectionRadius/CollisionShape2D.shape = circle_collision
	$DetectionRadius/CollisionShape2D.shape.radius = detection_radius

func _process(delta):
	# Only aim and shoot if there is a target to shoot at
	if target:
		# Find the direction to the target
		var target_direction = (target.global_position - global_position).normalized()
		# Find our current rotation vector by applying our rotation value to a unit vector
		var curr_direction = Vector2(1,0).rotated($Turret.global_rotation)
		# Use linear interpolation to rotate our turret towards the target direction
		$Turret.global_rotation = curr_direction.linear_interpolate(target_direction, turret_speed * delta).angle()
		
		# After turning the turret, find how close we are to pointing at the target
		# If we are pointing close to the target, fire
		if target_direction.dot(curr_direction) > 0.9: # If == 1, angle is perfect
			shoot()


# When a player enters the radius of the enemy tank, set it to it's target
func _on_DetectionRadius_body_entered(body):
	if body.name == "PlayerTank":
		target = body

# If our target leaves the radius, clear our target
func _on_DetectionRadius_body_exited(body):
	if body == target:
		target = null
