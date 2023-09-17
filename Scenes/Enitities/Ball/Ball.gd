extends CharacterBody2D


const SPEED = 700.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	velocity = Vector2(5, SPEED)

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#	move_and_slide()
	var collision := move_and_collide(velocity * delta)
	
	if collision:
#		var angle = collision.get_angle()
#		print(angle)
		var colider_object = collision.get_collider() #this is player by by default
		
		#bricks have health
		if colider_object.get("health"):
			var brick_health = colider_object.get("health")
			colider_object.health = brick_health - 1
		
		velocity = velocity.bounce(collision.get_normal())
		
