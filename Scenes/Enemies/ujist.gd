extends CharacterBody2D


@export var speed: float
@export var glory_min: int
@export var glory_max: int

var direction: Vector2
var shoot_direction: Vector2

@onready var health_component: HealthComponent = $HealthComponent
@onready var effects := $Effects
@onready var sprite := $Sprite
@onready var weapon_slot := $WeaponSlot
@onready var weapon: Weapon = $WeaponSlot/Weapon


func _ready() -> void:
	health_component.health_depleted.connect(_on_health_depleted)
	health_component.health_changed.connect(_on_health_changed)
	
	direction = Vector2.from_angle(randf_range(0.0, TAU))


func _physics_process(delta: float) -> void:
	move(delta)
	handle_weapon()
	
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func move(delta: float) -> void:
	velocity = direction * speed
	var collision := move_and_collide(velocity * delta)
	if collision:
		var bounce_direction := direction.bounce(collision.get_normal())
		direction = bounce_direction


func handle_weapon() -> void:
	var dir: Vector2 = weapon_slot.global_position.direction_to(GameController.player.global_position)
	shoot_direction = dir
	var angle := dir.angle()
	weapon_slot.rotation = angle
	if weapon_slot.rotation_degrees > 90.0 or weapon_slot.rotation_degrees < -90.0:
		weapon.flip_v = true
	else:
		weapon.flip_v = false


func _on_health_changed() -> void:
	effects.play("hurt")


func _on_health_depleted() -> void:
	GameController.glory_points += randi_range(glory_min, glory_max)
	queue_free()
