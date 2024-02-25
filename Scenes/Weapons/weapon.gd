class_name Weapon
extends Sprite2D

const EnemyProjectileScene := preload("res://Scenes/Projectiles/enemy_projectile.tscn")

@export var damage: int
@export var volley: int
@export var type: String
@export var projectile_scene: PackedScene
@export var enemy := false

var shots_left := volley

var cooldown_timer: Timer
@onready var volley_timer := $VolleyTimer
@onready var shoot_sound := $ShootSound
@onready var animation := $Animation

# Reload multiplier ability
func _ready():
	cooldown_timer = $CooldownTimer
	if not enemy:
		if GameController.abilities["Contract"]["acquired"]:
			cooldown_timer.wait_time *= GameController.abilities["Contract"]["reload_multiplier"]
		if type == "Pistol":
			damage = GameController.weapons["gun"]["damage"]
		elif type == "Rifle":
			damage = GameController.weapons["laser_gun"]["damage"]
		elif type == "Book":
			damage = GameController.weapons["book"]["damage"]

	else:
		cooldown_timer.wait_time = 0.5
		

func shoot() -> void:
	if cooldown_timer.is_stopped():
		shots_left = volley
		cooldown_timer.start()
		if shots_left > 0:
			if not enemy:
				GameController.world.apply_shake()
				create_projectile()
			else:
				create_enemy_projectile()
			volley_timer.start()
			shots_left -= 1
		#visible = false  - used only in book
		animation.play("shoot")


func cannot_change() -> bool:
	return not cooldown_timer.is_stopped()


func create_projectile() -> void:
	shoot_sound.play()
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.damage = damage
	projectile.direction = GameController.player.get_shoot_direction()
	projectile.rotation = GameController.player.get_shoot_direction().angle()
	GameController.world.add_child(projectile)


func create_enemy_projectile() -> void:
	shoot_sound.play()
	var projectile: EnemyProjectile = EnemyProjectileScene.instantiate()
	projectile.global_position = global_position
	projectile.damage = 1
	projectile.direction = GameController.player.global_position - global_position
	GameController.world.add_child(projectile)


func _on_cooldown_timer_timeout() -> void:
	visible = true
	shots_left = volley


func _on_volley_timer_timeout() -> void:
	if shots_left > 0:
		if not enemy:
			create_projectile()
		else:
			create_enemy_projectile()
		volley_timer.start()
		shots_left -= 1
