class_name EnemyProjectile
extends HitboxComponent


@export var speed: float

var direction: Vector2


func _physics_process(delta: float) -> void:
	direction = direction.normalized()
	position += direction * speed * delta


func _on_area_entered(_area: HurtboxComponent) -> void:
	queue_free()


func _on_body_entered(_body: Node2D) -> void:
	queue_free()
