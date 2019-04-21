extends Node2D

func _ready():
	$Pause/PauseScreen.hide()
	$Water/Water/AnimationPlayer.play("Wave")