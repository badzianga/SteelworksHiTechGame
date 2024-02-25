class_name UI
extends CanvasLayer


@onready var health := $Health
@onready var glory_points := $GloryPoints
@onready var reputation_points := $ReputationPoints


func _ready() -> void:
	GameController.ui = self
	health.value = 3
	update_glory_points()
	update_reputation_points()


func apply_damage() -> void:
	health.value -= 1


func update_glory_points() -> void:
	glory_points.text = str(GameController.glory_points)


func update_reputation_points() -> void:
	reputation_points.text = str(GameController.reputation_points)
