class_name Weapon
extends Sprite2D


@export var damage: int
@export var projectile_scene: PackedScene

@onready var cooldown_timer := $CooldownTimer
@onready var volley_timer := $VolleyTimer


func shoot(direction: Vector2) -> void:
	if cooldown_timer.is_stopped():
		var projectile: Projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.damage = damage
		projectile.direction = direction
		get_tree().root.add_child(projectile)
		visible = false
		cooldown_timer.start()


func _on_cooldown_timer_timeout() -> void:
	visible = true
