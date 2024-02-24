class_name Weapon
extends Sprite2D


@export var damage: int
@export var volley: int
@export var projectile_scene: PackedScene

var shots_left := volley
var shot_direction: Vector2

@onready var cooldown_timer := $CooldownTimer
@onready var volley_timer := $VolleyTimer
@onready var shoot_sound := $ShootSound


func shoot(direction: Vector2) -> void:
	if cooldown_timer.is_stopped():
		shot_direction = direction
		shots_left = volley
		cooldown_timer.start()
		if shots_left > 0:
			create_projectile()
			volley_timer.start()
			shots_left -= 1
		#visible = false  - used only in book


func create_projectile() -> void:
	shoot_sound.play()
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.damage = damage
	projectile.direction = shot_direction
	projectile.rotation = shot_direction.angle()
	get_tree().root.add_child(projectile)


func _on_cooldown_timer_timeout() -> void:
	visible = true
	shots_left = volley


func _on_volley_timer_timeout() -> void:
	if shots_left > 0:
		create_projectile()
		volley_timer.start()
		shots_left -= 1
