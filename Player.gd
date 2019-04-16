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
		$AnimatedSprite.animation = "Walk"
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play()
	elif direction == "right":
		$AnimatedSprite.animation = "Walk"
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play()
		motion.x = SPEED
		$CollisionShape2D.position

func stop():
	motion.x = 0
	$AnimatedSprite.animation = "idle"
	$AnimatedSprite.play()

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
		if Input.is_action_pressed("ui_up"):
			jump()
			double = true

	if not is_on_floor() and double:
		if Input.is_action_pressed("ui_up"):
			jump()
			double = false

	if $CollisionShape2D.position.x >= screensize.x - 1000:
		stop()
		
	motion = move_and_slide(motion, UP)