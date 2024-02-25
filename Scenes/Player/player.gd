class_name Player
extends CharacterBody2D


@export var speed := 64.0

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer
@onready var weapon_slot: Marker2D = $WeaponSlot
@onready var health_component: HealthComponent = $HealthComponent
@onready var helmet_sprite := $HelmetSprite
@onready var invincibility_timer := $InvincibilityTimer
@onready var hurtbox_collision := $HurtboxComponent/CollisionShape
@onready var effects := $Effects
@onready var dash_cooldown := $DashCooldown
@onready var dashing_time := $DashingTime
@onready var weapons: Array[Weapon] = [
	$WeaponSlot/Book,
	$WeaponSlot/Pistol,
	$WeaponSlot/Rifle,
]

var direction := Vector2.ZERO
var shoot_direction := Vector2.ZERO
var collected_book := false
var can_dash := false
var dashing := false
var dash_multiplier := 3.0
var selected_weapon := 0

func _ready() -> void:
	if GameController.abilities["Beer"]["acquired"]:
		can_dash = true
	GameController.player = self
	health_component.health_changed.connect(_on_health_changed)
	health_component.health_depleted.connect(GameController.wave_again)
	GameController.room_changed.connect(_on_room_changed)
	
	helmet_sprite.visible = false
	weapon_slot.visible = false


func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_animation()
	switch_weapons()
	handle_weapon()


func switch_weapons() -> void:
	if weapons[selected_weapon].cannot_change():
		return
	if Input.is_action_just_pressed("weapon1"):
		if GameController.weapons["book"]["acquired"]:
			selected_weapon = 0
			weapons[0].visible = true
			weapons[1].visible = false
			weapons[2].visible = false
	elif Input.is_action_just_pressed("weapon2"):
		if GameController.weapons["gun"]["acquired"]:
			selected_weapon = 1
			weapons[0].visible = false
			weapons[1].visible = true
			weapons[2].visible = false
	elif Input.is_action_just_pressed("weapon3"):
		if GameController.weapons["laser_gun"]["acquired"]:
			selected_weapon = 2
			weapons[0].visible = false
			weapons[1].visible = false
			weapons[2].visible = true


func handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	if direction:
		if dashing:
			velocity = direction * speed * dash_multiplier
		else:
			velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if Input.is_action_just_pressed("dash") and can_dash and dash_cooldown.is_stopped():
		can_dash = false
		dashing = true
		hurtbox_collision.set_deferred("disabled", true)
		dashing_time.start()


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
		weapons[selected_weapon].flip_v = true
	else:
		weapons[selected_weapon].flip_v = false
	
	if Input.is_action_just_pressed("shoot") and helmet_sprite.visible:
		weapons[selected_weapon].shoot()


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
	if health_component.health == 0:
		return
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


func _on_dash_cooldown_timeout() -> void:
	can_dash = true


func _on_dashing_time_timeout() -> void:
	hurtbox_collision.set_deferred("disabled", false)
	dashing = false
	dash_cooldown.start()
