extends CharacterBody2D


@export var speed := 64.0

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer
@onready var gun_slot: Marker2D = $GunSlot
@onready var gun: Sprite2D = $GunSlot/Gun

var direction := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_animation()
	rotate_weapon()


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
	else:
		sprite.flip_h = false
	
	if direction:
		animation_player.play("run")
	else:
		animation_player.play("idle")


func rotate_weapon() -> void:
	var angle := gun_slot.global_position.direction_to(get_global_mouse_position()).angle()
	gun_slot.rotation = angle
	if gun_slot.rotation_degrees > 90.0 or gun_slot.rotation_degrees < -90.0:
		gun.flip_v = true
		gun.flip_h = true
	else:
		gun.flip_v = false
		gun.flip_h = false
