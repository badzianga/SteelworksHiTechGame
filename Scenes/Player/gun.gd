class_name Gun
extends Sprite2D


@export var cooldown := 1.0
@export var damage := 1.0
@export var projectile_scene: PackedScene

@onready var timer := $Timer


func _ready() -> void:
	timer.wait_time = cooldown


func shoot(dir: Vector2) -> void:
	if timer.is_stopped():
		var projectile: Projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.damage = damage
		projectile.direction = dir
		get_tree().root.add_child(projectile)
		visible = false
		timer.start()


func _on_timer_timeout() -> void:
	visible = true
