extends CharacterBody2D

# Patrol variables
var patrol_speed = 800
var patrol_range = 20 
var direction = 1 
var start_position : Vector2 
var health = 5 
var attack_range = 200

@export var animated_skeleton : AnimatedSprite2D
@export var player : CharacterBody2D  # Adjust path to player
@export var hitbox : Area2D

var is_dead = false
var is_attacking = false
var is_patrolling = true

func _ready():
	start_position = position

func _physics_process(delta: float) -> void:
	if is_dead: 
		die()
	if is_attacking:
		attack()
	if is_patrolling:
		patrol(delta)
	
	move_and_slide()

	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if direction < 0:
		animated_skeleton.flip_h = true
		hitbox.position.x = -30 
	elif direction > 0:
		animated_skeleton.flip_h = false
		hitbox.position.x = 12 

func patrol(_delta : float):
	if is_attacking:
		return
	var target_position = start_position + Vector2(patrol_range * direction, 0)
	var movement = (target_position - position).normalized() * patrol_speed * _delta
	velocity.x = movement.x
	if position.distance_to(target_position) < 10:
		direction *= -1
	animated_skeleton.play("run")
	is_patrolling = true

func take_damage(amount: int) -> void:
	health -= amount
	print("Enemy health: ", health)
	if health <= 0:
		play_death_anim()

func play_death_anim() -> void:
	is_patrolling = false
	is_attacking = false
	is_dead = true
	print("Enemy has died!")
	animated_skeleton.play("death")
	
func die():
	velocity.x = 0
	if animated_skeleton.frame >= 14:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player detected!")
		player.take_damage(1)
		is_attacking = true
		
func attack():
	is_patrolling = false
	velocity.x = 0
	animated_skeleton.play("attack")
	if animated_skeleton.frame >= 17:
		is_attacking = false
		is_patrolling = true
		
