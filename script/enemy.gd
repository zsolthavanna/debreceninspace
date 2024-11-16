extends CharacterBody2D

# Patrol variables
var patrol_speed = 800
var patrol_range = 20 
var direction = 1 
var start_position : Vector2 
var health = 5 

@onready var sprite = $Sprite  

func _ready():
	start_position = position

func _physics_process(delta: float) -> void:

	var target_position = start_position + Vector2(patrol_range * direction, 0)


	var movement = (target_position - position).normalized() * patrol_speed * delta


	velocity.x = movement.x  
	move_and_slide()

	if position.distance_to(target_position) < 10:
		direction *= -1  


func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health: ", health)
	if health <= 0:
		die()


func die() -> void:
	print("Enemy has died!")
	queue_free()
