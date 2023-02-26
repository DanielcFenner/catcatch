extends Node2D

@export var drop_scene: PackedScene
var score = 0
var lives = 3


func _ready():
	pass


func _on_spawn_timer_timeout():
	var spawn1 = $Spawners/Spawn1
	var spawn2 = $Spawners/Spawn2
	var spawn3 = $Spawners/Spawn3
	var spawns = [spawn1.position, spawn2.position, spawn3.position]
	
	var random_spawn_location = spawns[randi() % 3]
	
	var drop = drop_scene.instantiate()
	add_child(drop)
	drop.position = random_spawn_location


func _on_player_catch():
	$Catch.play()
	score += 1
	$HUD.updateScore(score)


func _on_area_2d_body_entered(body):
	lives -= 1
	print(lives)
