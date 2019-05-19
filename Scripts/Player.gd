extends KinematicBody2D

const UP = Vector2(0, -1)

var GRAVITY = 20
var WATER_F = 1
var jump_heigth = -500
var speed = 200
var velocity = Vector2()
var can_double_jump = false
var can_jump = false
var is_in_water = false
var screensize
var sea_level

func swim():
	velocity.y = clamp(velocity.y, -80, 400) 
	$Sprite/AnimationPlayer.play("Walk")
	if position.y - sea_level < 100:
		velocity.y -= WATER_F * (position.y - sea_level)
		if (Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_up")):
			jump()
	else:
		velocity.y = 0
		
		if Input.is_action_pressed("ui_select") or Input.is_action_pressed("ui_up"):
			velocity.y = -100
	if Input.is_action_pressed("ui_down"):
		velocity.y = 100

func crawl():
	velocity.x = 0
	velocity.y = 0
	$Sprite/AnimationPlayer.play("Crawl")

func jump():
	if is_in_water:
		is_in_water = false

	if can_jump:
		$Sprite/AnimationPlayer.play("Jump")
	elif can_double_jump:
		if velocity.x <= 0:
			$Sprite/AnimationPlayer.play("Rotate")
		elif velocity.x > 0:
			$Sprite/AnimationPlayer.play_backwards("Rotate")
	if can_jump or can_double_jump: 
		velocity.y = jump_heigth
		can_jump = false
		can_double_jump = !can_double_jump

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
	
	if is_in_water:
		can_jump = true
		swim()
	
	if is_on_floor():
		can_jump = true

	if Input.is_action_pressed("ui_right"):
		walk("right")
	elif Input.is_action_pressed("ui_left"):
		walk("left")
	else:
		stop()

	if (Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_up")):
		jump()

	if Input.is_action_pressed("ui_down"):
		if is_on_floor():
			crawl()

	if is_on_wall():
		stop()

	velocity = move_and_slide(velocity, UP)

func _on_Area2D_body_entered(body):
	if not is_in_water:
		sea_level = position.y
		is_in_water = true

func _on_Area2D_body_exited(body):
	is_in_water = false
