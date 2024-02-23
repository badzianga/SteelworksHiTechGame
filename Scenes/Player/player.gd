extends CharacterBody2D


@export var max_speed := 64.0
@export var acceleration := 56.0

@onready var sprite := $Sprite


func _physics_process(_delta: float) -> void:
	handle_movement()


func handle_movement() -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	if direction:
		velocity = direction * max_speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
