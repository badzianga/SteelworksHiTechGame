extends Node2D

# Economy labels
func _physics_process(delta):
	%GloryPoints.text = str(GameController.glory_points)
	%ReputationPoints.text = str(GameController.reputation_points)
