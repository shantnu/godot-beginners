extends KinematicBody2D

const SPEED = 200
const GRAVITY = 20
var velocity = Vector2(0,0)

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0
	velocity.y += 20
	velocity = move_and_slide(velocity)		
	
func _ready():
	pass
