extends CharacterBody2D

# Setup messages to send
signal tank_shoot
signal health_changed
signal dead

# Set up variables configurable from the inspector  
@export var Bullet : PackedScene
@export var speed : int
@export var max_health : int
@export var rotation_speed : float
@export var gun_cooldown : float


# Set up local tank info variables
var tank_velocity = Vector2()
var can_shoot = true
var alive = true
var tank_health


# Assign our gun timer its appropriate cooldown
func _ready():
	tank_health = max_health
	if max_health == 0: max_health = 1
	emit_signal('health_changed', tank_health * 100 / max_health) # Pass percentage of health left to UI element
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
		emit_signal('tank_shoot', Bullet, $Turret/Muzzle.global_position, direction)

func take_damage(amount):
	if tank_health != null:
		tank_health -= amount
		if max_health == 0: max_health = 1 # Avoid divide by 0 error
		emit_signal('health_changed', tank_health * 100 / max_health) # Pass percentage of health left to UI element
		if tank_health <= 0:
			explode()
		
func explode():
	emit_signal('dead')
	queue_free()
	
# If we are alive still, apply our controls and movement
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	set_velocity(tank_velocity)
	move_and_slide()


func _on_GunTimer_timeout():
	pass # Replace with function body.
	can_shoot = true
