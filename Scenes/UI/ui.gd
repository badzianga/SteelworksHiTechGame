class_name UI
extends CanvasLayer


@onready var health := $Health
@onready var glory_points := $GloryPoints
@onready var reputation_points := $ReputationPoints
@onready var patience_bar := $PatienceBar
@onready var patience_timer := $PatienceTimer


func _ready() -> void:
	GameController.ui = self
	health.value = 3
	update_glory_points()
	update_reputation_points()
	var time: int = GameController.wave_info[GameController.current_wave]["time"]
	patience_timer.wait_time = time
	patience_bar.min_value = 0
	patience_bar.max_value = time
	patience_bar.value = time
	patience_timer.start()


func _process(_delta: float) -> void:
	patience_bar.value = patience_timer.time_left


func apply_damage() -> void:
	health.value -= 1


func update_glory_points() -> void:
	glory_points.text = str(GameController.glory_points)


func update_reputation_points() -> void:
	reputation_points.text = str(GameController.reputation_points)


func get_time_left() -> float:
	return patience_timer.time_left


func _on_patience_timer_timeout() -> void:
	GameController.finish_wave(false)
