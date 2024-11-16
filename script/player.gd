extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const AIR_CONTROL = 1.0 # Air control factor (0.0 = no control, 1.0 = full control)

var health = 5  # Player's current health

@onready var animation_player = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node

func _ready():
	# Initialize health (if needed)
	health = 5

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("ui_accept")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED

		if direction < 0:
			animation_player.flip_h = true  
		elif direction > 0:
			animation_player.flip_h = false  

		animation_player.play("run")  
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_player.play("idle") 

	if not is_on_floor():
		if AIR_CONTROL == 0.0:
			velocity.x = 0
		else:
			velocity.x = lerp(velocity.x, direction * SPEED, AIR_CONTROL)

	move_and_slide()

	if health <= 0:
		die()

func take_damage(amount: int) -> void:
	health -= amount
	print("Player health: ", health)
	if health <= 0:
		die()

# Function to handle player death
func die() -> void:
	print("Player has died!")
	queue_free()  
