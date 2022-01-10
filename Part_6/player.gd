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
	get_parent().get_node("hud/coins_found").text = str(coins_found) + " / " + str(TOTAL_COINS)
	get_parent().get_node("hud/lives_left").text = str(Globals.player_lives)

func die():
	Globals.player_lives -= 1
	if Globals.player_lives > 0:
		# warning-ignore:return_value_discarded
		get_parent().get_node("hud/lives_left").text = str(Globals.player_lives)
		get_tree().change_scene("res://level1.tscn")
	else:
		print("You died!")
		Globals.player_lives  = 3
		get_tree().change_scene("res://lose.tscn")
#

func _on_fallzone_body_entered(_body):
	print("fallzone entered")
	die()


func _on_spikes_body_entered(_body):
# warning-ignore:return_value_discarded
	print("spikes entered")
	die()


func _on_coin_body_entered(_body):
	coins_found += 1
	print("coins found =", coins_found)
	get_parent().get_node("hud/coins_found").text = str(coins_found) + " / " + str(TOTAL_COINS)
	if coins_found == TOTAL_COINS:
		print("You win!")
		Globals.player_lives  = 3
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://win.tscn")
	else:
		print(TOTAL_COINS)			
	


func _on_enemy_player_hit():
	print("You were hit by the enemy!")
# warning-ignore:return_value_discarded
	die()
	
