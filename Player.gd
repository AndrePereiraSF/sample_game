extends KinematicBody2D

const UP = Vector2(0, -1)

var GRAVITY = 20
var jump_heigth = -500
var speed = 200
var motion = Vector2()
var can_double_jump = false
var screensize

func jump():
	motion.y = jump_heigth
	if !can_double_jump:
		$Sprite/AnimationPlayer.play("Jump")
	elif can_double_jump:
		$Sprite/AnimationPlayer.play("Double Jump")

func walk(direction):
	if direction == "left":
		motion.x = -speed
		$Sprite.flip_h = true
	elif direction == "right":
		motion.x = speed
		$Sprite.flip_h = false
	if is_on_floor():
		$Sprite/AnimationPlayer.play("Walk")

func stop():
	if is_on_floor():
		$Sprite/AnimationPlayer.play("Idle")
		motion.y = 0
	motion.x = 0
	

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(delta):
	position.x = clamp(position.x, 0, screensize.x )
	motion.y += GRAVITY

	if Input.is_action_pressed("ui_right"):
		walk("right")
	elif Input.is_action_pressed("ui_left"):
		walk("left")
	else:
		stop()

	if Input.is_action_just_pressed("ui_select") and can_double_jump:
		jump()
		can_double_jump = false
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		jump()
		can_double_jump = true

	if is_on_wall():
		stop()

	motion = move_and_slide(motion, UP)
