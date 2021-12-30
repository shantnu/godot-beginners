extends KinematicBody2D

var velocity = Vector2(0,0)
const GRAVITY = 20
var SPEED = 30
var counter = 0

signal player_hit

func _ready():
	pass

func _physics_process(_delta):
	counter += 1
	velocity.x = SPEED
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	$AnimatedSprite.play("walk")
	if counter >= 100:
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		SPEED *= -1
		counter = 0


func _on_AREA_BODY_body_entered(body):
	if body.get_name() == "player":
		emit_signal("player_hit")


func _on_AREA_TOP_body_entered(body):
	if body.get_name() == "player":
		print("enemy dead!")
		queue_free()
