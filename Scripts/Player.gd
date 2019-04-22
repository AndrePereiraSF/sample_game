extends KinematicBody2D

const UP = Vector2(0, -1)

var GRAVITY = 20
var jump_heigth = -500
var speed = 200
var velocity = Vector2()
var can_double_jump = false
var screensize

func crawl():
	velocity.x = 0
	velocity.y = 0
	$Sprite/AnimationPlayer.play("Crawl")

func jump():
	velocity.y = jump_heigth
	if !can_double_jump:
		$Sprite/AnimationPlayer.play("Jump")
	elif can_double_jump:
		if velocity.x <= 0:
			$Sprite/AnimationPlayer.play("Rotate")
		elif velocity.x > 0:
			$Sprite/AnimationPlayer.play_backwards("Rotate")			

func walk(direction):
	if direction == "left":
		velocity.x = -speed
		$Sprite.flip_h = true
	elif direction == "right":
		velocity.x = speed
		$Sprite.flip_h = false
	if is_on_floor():
		$Sprite/AnimationPlayer.play("Walk")

func stop():
	if is_on_floor():
		$Sprite/AnimationPlayer.play("Idle")
		velocity.y = 0
	velocity.x = 0
	

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(delta):
	position.x = clamp(position.x, 0, screensize.x )
	velocity.y += GRAVITY

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

	if Input.is_action_pressed("ui_down"):
		if is_on_floor():
			crawl()

	if is_on_wall():
		stop()

	velocity = move_and_slide(velocity, UP)


func _on_Area2D_body_entered(body):
	print("Water entered")