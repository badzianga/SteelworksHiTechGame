extends StaticBody2D


@onready var sprite := $Sprite


func _ready() -> void:
	sprite.frame = randi_range(0, 3)


func _on_alpha_area_area_entered(_area: Area2D):
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 0.4), 0.2)


func _on_alpha_area_area_exited(_area: Area2D):
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)
