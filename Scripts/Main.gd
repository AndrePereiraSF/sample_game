extends Node2D

func _ready():
	$Pause/PauseScreen.hide()
	$Water/Area2D/AnimationPlayer.play("Wave")