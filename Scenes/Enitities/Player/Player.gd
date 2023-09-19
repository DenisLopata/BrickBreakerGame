extends CharacterBody2D


const SPEED = 3000.0
const JUMP_VELOCITY = -400.0

var is_level_started := false
var is_dragging := false
var touch_pos : Vector2
var initial_position : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	initial_position = position
	
func reset_player() -> void:
	is_level_started = false
	position = initial_position

func start_player() -> void:
	is_level_started = true

func _input(event) -> void:
		
	if event is InputEventScreenDrag:
		# process drag
		is_dragging = true
		touch_pos = event.position
		pass
	elif event is InputEventScreenTouch:
		# process touch
		var pressed = event.pressed
		if not pressed:
			is_dragging = false
		pass

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_level_started: 
	#	if is_on_wall():
	#		print("on wall")
	#	if is_on_ceiling():
	#		print("on ceiling")
			
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if is_dragging:
	#		velocity = touch_pos
	#		velocity = position.direction_to(touch_pos) * SPEED
			var distance = position.direction_to(touch_pos) * SPEED
			velocity.x = distance.x
			
	#	if Input is InputEventScreenDrag:
	#		# process drag
	#		pass
	#	elif Input is InputEventScreenTouch:
	#		# process touch
	#		pass
			
	move_and_slide()
