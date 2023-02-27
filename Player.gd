extends Area2D

signal catch
signal death

var speed = 500
var	default_position = 164
var left_position = 118  # adjust this value to change the left position
var right_position = 208  # adjust this value to change the right position


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerSprite.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$PlayerSprite.play("running")
		$PlayerSprite.flip_h = true
		if position.x > left_position:
			position.x -= speed * delta
		else:
			position.x = left_position
	elif Input.is_action_pressed("ui_right"):
		$PlayerSprite.play("running")
		$PlayerSprite.flip_h = false
		if position.x < right_position:
			position.x += speed * delta
		else:
			position.x = right_position
	else: 
		$PlayerSprite.play("idle")
		if int(position.x) > default_position:
			$PlayerSprite.flip_h = true
			position.x -= speed * delta
		elif int(position.x) < default_position:
			$PlayerSprite.flip_h = false
			position.x += speed * delta
		else:
			position.x = default_position


func _on_Player_body_entered(body):
	if body.drop_type == "drop":
		emit_signal("catch")
		body.queue_free()
	elif body.drop_type == "bomb":
		emit_signal("death")
		body.queue_free()

	
