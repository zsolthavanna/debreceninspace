
# generated code
extends Area2D

@export var energy_value = 10  # Amount of energy this energem provides

signal picked_up  # Signal emitted when the energem is picked up


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Check if the entering area is the player
		body.add_energy(energy_value)  # Add energy to the player
		emit_signal("picked_up")  # Emit a signal for other systems
		queue_free()  # Remove the energem from the scene
