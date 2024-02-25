extends CharacterBody2D


@export var speed: float
@export var glory_min: int
@export var glory_max: int

@onready var health_component: HealthComponent = $HealthComponent
@onready var effects := $Effects


func _ready() -> void:
	health_component.health_depleted.connect(_on_health_depleted)
	health_component.health_changed.connect(_on_health_changed)
	
	# Possibility of malfunction ability
	if GameController.abilities["BAThesis"]["acquired"]:
		if randi_range(1, 100) <= GameController.abilities["BAThesis"]["malfunction"]:
			%ExplosionTimeout.wait_time = randi_range(1, 2)
			%ExplosionTimeout.start()


func _physics_process(_delta: float) -> void:
	move_towards_player()


func move_towards_player() -> void:
	var direction := global_position.direction_to(GameController.player.global_position)
	look_at(GameController.player.global_position)
	velocity = direction * speed
	move_and_slide()


func _on_health_changed() -> void:
	effects.play("hurt")


func _on_health_depleted() -> void:
	GameController.glory_points += randi_range(glory_min, glory_max)
	GameController.ui.update_glory_points()
	queue_free()


func _on_explosion_timeout_timeout() -> void:
	GameController.glory_points += randi_range(glory_min, glory_max)
	GameController.ui.update_glory_points()
	$Sprite.visible = false
	set_physics_process(false)
	$HurtboxComponent/CollisionShape.set_deferred("disabled", true)
	effects.play("explosion")
	await effects.animation_finished
	queue_free()
