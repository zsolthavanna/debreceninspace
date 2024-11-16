extends CharacterBody2D

const SPEED = 300.0
const MOVE_DISTANCE = 500.0 
var start_position : Vector2
var moving_left : bool = true  # Track if the enemy is moving left

func _ready() -> void:
	start_position = position  # Store the initial position of the enemy

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
	# Set horizontal movement direction
	if moving_left:
		velocity.x = -SPEED  # Move left
	else:
		velocity.x = SPEED  # Move right

	# Move and slide the character using the velocity
	move_and_slide()

	# Check if the enemy has reached the specified distance
	if abs(position.x - start_position.x) >= MOVE_DISTANCE:
		moving_left = not moving_left  # Flip the direction
		start_position = position  # Reset the start position for the new direction
