extends KinematicBody2D

const SPEED = 200
const GRAVITY = 20
const JUMP_SPEED=700
var velocity = Vector2(0,0)
var coins_found = 0
var TOTAL_COINS = 0

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
	coins_found = 0
	TOTAL_COINS=get_parent().get_node("coins").get_child_count()


func _on_fallzone_body_entered(_body):
	
	get_tree().change_scene("res://level1.tscn")


func _on_spikes_body_entered(_body):
	get_tree().change_scene("res://level1.tscn")


func _on_coin_body_entered(_body):
	coins_found += 1
	print("coins found =", coins_found)
	if coins_found == TOTAL_COINS:
		print("You win!")
	else:
		print(TOTAL_COINS)			
	
