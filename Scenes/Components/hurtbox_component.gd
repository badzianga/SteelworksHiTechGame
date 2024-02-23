class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent

 
func _on_area_entered(hitbox: HitboxComponent) -> void:
	health_component.apply_damage(hitbox.damage)
