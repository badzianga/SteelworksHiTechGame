class_name Player
extends CharacterBody2D


@export var speed := 64.0

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer
@onready var weapon_slot: Marker2D = $WeaponSlot
@onready var weapon: Weapon = $WeaponSlot/Weapon
@onready var health_component: HealthComponent = $HealthComponent
@onready var helmet_sprite := $HelmetSprite

var direction := Vector2.ZERO
var shoot_direction := Vector2.ZERO


func _ready() -> void:
	GameController.player = self
	health_component.health_changed.connect(_on_health_changed)


func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_animation()
	handle_weapon()


func handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func handle_animation() -> void:
	var dir := get_global_mouse_position() - global_position
	if dir.x < 0:
		sprite.flip_h = true
		helmet_sprite.flip_h = true
	else:
		sprite.flip_h = false
		helmet_sprite.flip_h = false
	
	if direction:
		animation_player.play("run")
	else:
		animation_player.play("idle")


func handle_weapon() -> void:
	var dir := weapon_slot.global_position.direction_to(get_global_mouse_position())
	shoot_direction = dir
	var angle := dir.angle()
	weapon_slot.rotation = angle
	if weapon_slot.rotation_degrees > 90.0 or weapon_slot.rotation_degrees < -90.0:
		weapon.flip_v = true
		#weapon.flip_h = true
	else:
		weapon.flip_v = false
		#weapon.flip_h = false
	
	if Input.is_action_just_pressed("shoot"):
		weapon.shoot()


func get_shoot_direction() -> Vector2:
	return shoot_direction


func _on_health_changed() -> void:
	GameController.ui.apply_damage()

