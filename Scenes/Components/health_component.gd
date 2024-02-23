class_name HealthComponent
extends Node2D


signal health_changed
signal health_depleted

@export var max_health: float

var health := 0.0


func _ready() -> void:
	health = max_health


func apply_damage(amount: float) -> void:
	health -= amount
	health_changed.emit()
	if health <= 0.0:
		health_depleted.emit()


func heal(amount: float) -> void:
	apply_damage(-amount)
