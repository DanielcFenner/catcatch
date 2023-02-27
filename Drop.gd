extends RigidBody2D

@export var drop_type : String

func _ready():
	angular_velocity = randi() % 40
	var random_fruit = randi() % 59
	choose_drop()
	
	
func choose_drop():
	var random = randi() % 20
	if random == 1:
		$AnimatedSprite2D.set_frame(34)
		drop_type = "bomb"
	else:
		$AnimatedSprite2D.set_frame(1)
		drop_type = "drop"

