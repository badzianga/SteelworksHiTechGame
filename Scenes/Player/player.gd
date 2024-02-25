class_name Player
extends CharacterBody2D


@export var speed := 64.0

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer
@onready var weapon_slot: Marker2D = $WeaponSlot
@onready var weapon: Weapon = $WeaponSlot/Weapon
@onready var health_component: HealthComponent = $HealthComponent
@onready var helmet_sprite := $HelmetSprite
@onready var invincibility_timer := $InvincibilityTimer
@onready var hurtbox_collision := $HurtboxComponent/CollisionShape
@onready var effects := $Effects


var direction := Vector2.ZERO
var shoot_direction := Vector2.ZERO
var collected_book := false

func _ready() -> void:
	GameController.player = self
	health_component.health_changed.connect(_on_health_changed)
	GameController.room_changed.connect(_on_room_changed)
	
	helmet_sprite.visible = false
	weapon_slot.visible = false


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
	else:
		weapon.flip_v = false
	
	if Input.is_action_just_pressed("shoot") and helmet_sprite.visible:
		weapon.shoot()


func get_shoot_direction() -> Vector2:
	return shoot_direction


func frame_freeze(time_scale: float, duration: float) -> void:
	sprite.material.set_shader_parameter("flash_state", 1.0)
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1.0
	invincibility_timer.start()
	effects.play("blinking")


func _on_health_changed() -> void:
	GameController.ui.apply_damage()
	GameController.world.enable_chromatic_aberration()
	hurtbox_collision.set_deferred("disabled", true)
	frame_freeze(0.05, 1.0)


func _on_room_changed(new_position: Vector2) -> void:
	print("Room changed")
	if new_position.y > MapGenerator.ARRAY_ROWS * 180.0 - 8.0:
		helmet_sprite.visible = false
		weapon_slot.visible = false
	else:
		helmet_sprite.visible = true
		weapon_slot.visible = true


func _on_invincibility_timer_timeout() -> void:
	hurtbox_collision.set_deferred("disabled", false)
