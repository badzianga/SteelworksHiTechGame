extends StaticBody2D


@onready var health_component: HealthComponent = $HealthComponent
@onready var effects := $Effects


func _ready() -> void:
	health_component.health_depleted.connect(queue_free)
	health_component.health_changed.connect(_on_health_changed)


func _physics_process(_delta: float) -> void:
	rotation_degrees += 10.0


func _on_health_changed() -> void:
	effects.play("hurt")
