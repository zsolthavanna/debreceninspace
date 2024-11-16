extends Node2D

const SPEED = 100.0

var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
	if ray_cast_left.is_colliding():
		direction = 1
	position.x += direction * SPEED * delta
	
	var isLeft = direction < 0 
	sprite_2d.flip_h = isLeft

# Function to handle collision with the player
func _on_collision_with_player(player):
	if player.velocity.y < 0:  # If player is moving upwards (jumping)
		queue_free()  # Enemy is defeated
	else:
		player._on_player_died()  # Call player's death function
