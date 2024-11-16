extends CharacterBody2D

# Patrol variables
var patrol_speed = 800
var patrol_range = 20 
var direction = 1 
var start_position : Vector2 
var health = 5 
var attack_range = 200

@onready var sprite = $Icon
@onready var player = get_node_or_null("/Icon/CharacterBody2D")  # Adjust path to player

func _ready():
	start_position = position

func _physics_process(delta: float) -> void:
	var target_position = start_position + Vector2(patrol_range * direction, 0)
	var movement = (target_position - position).normalized() * patrol_speed * delta
	velocity.x = movement.x  
	move_and_slide()

	if position.distance_to(target_position) < 10:
		direction *= -1  

	check_attack_range()

func check_attack_range() -> void:
	if player:
		var dist = position.distance_to(player.position)
		print("Distance to player: ", dist)  # Debugging distance
		if dist <= attack_range:
			print("Player is within attack range")
			deal_damage_to_player()

func deal_damage_to_player() -> void:
	if player:
		print("Dealing damage to player")
		player.take_damage(1)

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health: ", health)
	if health <= 0:
		die()

func die() -> void:
	print("Enemy has died!")
	queue_free()  # Remove the enemy from the scene when it dies
