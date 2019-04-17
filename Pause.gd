extends CanvasLayer

var is_paused = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		is_paused = !is_paused
		if is_paused:
			$ColorRect.show()
			$Label.show()
			get_tree().paused = true
		elif !is_paused:
			$ColorRect.hide()
			$Label.hide()
			get_tree().paused = false