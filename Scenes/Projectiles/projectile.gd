class_name Projectile
extends HitboxComponent


@export var speed: float

var direction: Vector2


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	special_behavior(delta)


func special_behavior(_delta: float) -> void:
	pass


func _on_area_entered(_area: HurtboxComponent) -> void:
	queue_free()
