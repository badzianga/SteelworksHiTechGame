extends CharacterBody2D


@export var max_speed := 64.0
@export var acceleration := 56.0

@onready var sprite := $Sprite
@onready var animation_player := $AnimationPlayer

var direction := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_animation()


func handle_movement() -> void:
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	if direction:
		velocity = direction * max_speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func handle_animation() -> void:
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
	
	if direction:
		animation_player.play("run")
	else:
		animation_player.play("idle")
