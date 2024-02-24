class_name UI
extends CanvasLayer


@onready var health := $Health


func _ready() -> void:
	GameController.ui = self
	health.value = 3


func apply_damage() -> void:
	health.value -= 1
