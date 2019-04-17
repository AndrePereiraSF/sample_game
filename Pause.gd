extends CanvasLayer

var is_paused = false

func pause():
	$PauseScreen.show()
	get_tree().paused = true

func resume():
	$PauseScreen.hide()
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		is_paused = !is_paused
		if is_paused:
			pause()
		elif !is_paused:
			resume()

func _on_ResumeButton_pressed():
	resume()

func _on_QuitButton_pressed():
	get_tree().quit()