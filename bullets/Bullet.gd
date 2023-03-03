extends Area2D

# Set up variables configurable from the inspector
@export var speed : int
@export var damage : int
@export var lifetime : float

# Create a vector to track the bullets speed & direction
var velocity = Vector2()

# On start, use the position, direction, and speed to calculate the velocity 
func start(_postion, _direction):
	position = _postion
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime # Start the lifetime timer upon creation
	velocity = _direction * speed
	$Lifetime.start()
	
# Using the bullets velocity, update its position regularly
func _process(delta):
	position += velocity * delta

# Create a function to run when a bullet hits something
func bullet_hit():
	queue_free()

# If we get a lifetime timeout, do not explode or apply damage. Just delete from scene
func _on_Lifetime_timeout():
	queue_free()

# When the bullet hits something, call bullet_hit() and then apply damage if needed
func _on_Bullet_body_entered(body):
	bullet_hit()
	# Check if collided body can take_damage()
	if body.has_method('take_damage'):
		body.take_damage(damage)
