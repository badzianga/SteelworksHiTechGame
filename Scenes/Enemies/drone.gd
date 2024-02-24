extends CharacterBody2D


@export var speed: float

@onready var health_component: HealthComponent = $HealthComponent
@onready var effects := $Effects


func _ready() -> void:
	health_component.health_depleted.connect(queue_free)
	health_component.health_changed.connect(_on_health_changed)


func _physics_process(_delta: float) -> void:
	move_towards_player()


func move_towards_player() -> void:
	var direction := global_position.direction_to(GameController.player.global_position)
	look_at(GameController.player.global_position)
	velocity = direction * speed
	move_and_slide()


func _on_health_changed() -> void:
	effects.play("hurt")
