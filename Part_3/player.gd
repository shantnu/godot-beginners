extends KinematicBody2D

const SPEED = 200
const GRAVITY = 20
const JUMP_SPEED=700
var velocity = Vector2(0,0)

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")
	
	if Input.is_action_pressed("up")  and is_on_floor() :
		velocity.y -= JUMP_SPEED		
	if not is_on_floor():
		$AnimatedSprite.play("jump")
		
	velocity.y += 20
	velocity = move_and_slide(velocity, Vector2.UP)		
	
func _ready():
	pass
