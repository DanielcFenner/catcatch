extends RigidBody2D



func _ready():
	angular_velocity = randi() % 20
	var random_fruit = randi() % 59
	$AnimatedSprite2D.set_frame(random_fruit)

