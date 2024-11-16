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
