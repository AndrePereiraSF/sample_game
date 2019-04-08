extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 2

func _ready():
	pass 

func _physics_process(delta):
	var velocity = Vector2()
	velocity.y += delta * GRAVITY
	if Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	else:
		velocity.x = 0
	var motion = velocity * GRAVITY
	move_and_slide(motion, Vector2(0, -1))