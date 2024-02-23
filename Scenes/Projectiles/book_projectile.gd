extends Projectile


func special_behavior(delta: float) -> void:
	rotation_degrees += 270.0 * delta
