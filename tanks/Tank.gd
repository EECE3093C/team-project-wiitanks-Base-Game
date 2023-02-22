extends KinematicBody2D

# Setup messages to send
signal shoot
signal health_change
signal dead

# Set up variables configurable from the inspector  
export (PackedScene) var Bullet
export (int) var speed
export (int) var health
export (float) var rotation_speed
export (float) var gun_cooldown

# Set up local tank info variables
var velocity = Vector2()
var can_shoot = true
var alive = true

# Assign our gun timer its appropriate cooldown
func _ready():
	$GunTimer.wait_time = gun_cooldown

# Empty controls function to be modified in the derived classes
func control(delta):
	pass

# Function to handle shooting a bullet
func shoot():
	if can_shoot:
		# If we can shoot, immediately mark ourselves as cannot shoot and start timer
		can_shoot = false
		$GunTimer.start()
		# To help with readability, pull the turret rotation into a variable
		var direction = Vector2(1,0).rotated($Turret.global_rotation)
		# Emit a shoot signal with the bullet prefab, its position, and its direction
		emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, direction)

# If we are alive still, apply our controls and movement
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)


func _on_GunTimer_timeout():
	pass # Replace with function body.
	can_shoot = true
