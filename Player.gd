extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 300
const JUMP_HEIGHT = -550
var motion = Vector2()
var double = false

func jump():
	motion.y = JUMP_HEIGHT

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			jump()
			double = true

	if not is_on_floor() and double:
		if Input.is_action_pressed("ui_up"):
			jump()
			double = false
	
	motion = move_and_slide(motion, UP)