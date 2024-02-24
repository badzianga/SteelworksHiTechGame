extends Sprite2D


@onready var animation_player := $AnimationPlayer


func _on_open_area_entered(_area: Area2D) -> void:
	animation_player.play("open", -1, 1.0, false)


func _on_open_area_exited(_area: Area2D) -> void:
	animation_player.play("open", -1, -1.0, true)
