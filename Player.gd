extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 300
const JUMP_HEIGHT = -550
var motion = Vector2()
var double = false
var screensize

func jump():
	motion.y = JUMP_HEIGHT

func walk(direction):
	if direction == "left":
		motion.x = -SPEED
		$Sprite/AnimationPlayer.play("Walk")
		$Sprite.flip_h = true
	elif direction == "right":
		motion.x = SPEED
		$Sprite/AnimationPlayer.play("Walk")
		$Sprite.flip_h = false


func stop():
	motion.x = 0
	$Sprite/AnimationPlayer.play("Idle")

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		walk("right")
	elif Input.is_action_pressed("ui_left"):
		walk("left")
	else:
		stop()
	if is_on_floor():
		if Input.is_action_pressed("space"):
			jump()

	motion = move_and_slide(motion, UP)