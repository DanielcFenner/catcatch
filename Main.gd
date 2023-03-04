extends Node2D

@export var drop_scene: PackedScene
@onready var spawn1 = $Spawners/Spawn1
@onready var spawn2 = $Spawners/Spawn2
@onready var spawn3 = $Spawners/Spawn3
@onready var spawns = [spawn1.position, spawn2.position, spawn3.position]
var score = 0

func _ready():
	pass

func game_start():
	var drops = get_tree().get_nodes_in_group("drops")
	for drop in drops:
		drop.queue_free()
	score = 0
	$HUD.updateScore(score)
	$HUD.duringGame()
	$Spawners/SpawnTimer.start()
	$Player.monitoring = true
	$BackgroundMusic.play()

func game_over():
	$HUD.preGame()
	$Spawners/SpawnTimer.stop()
	$Player.monitoring = false
	$BackgroundMusic.stop()
	$DeathExplosion.play()
	

func _on_spawn_timer_timeout():
	var base_spawn_time = 0.2
	if score < 10:	
		$Spawners/SpawnTimer.wait_time = randf() * 0.6 + base_spawn_time
	elif score < 25:
		$Spawners/SpawnTimer.wait_time = randf() * 0.5 + base_spawn_time
	elif score < 50:
		$Spawners/SpawnTimer.wait_time = randf() * 0.4 + base_spawn_time
	elif score < 75:
		$Spawners/SpawnTimer.wait_time = randf() * 0.3 + base_spawn_time
	else:
		$Spawners/SpawnTimer.wait_time = randf() * 0.2 + base_spawn_time

	var random_spawn_location = spawns[randi() % 3]
	
	var drop = drop_scene.instantiate()
	add_child(drop)
	drop.position = random_spawn_location


func _on_player_catch():
	$Catch.play()
	score += 1
	$HUD.updateScore(score)


func _on_area_2d_body_entered(body):
	if body.drop_type == "drop":
		game_over()
	else:
		body.queue_free()


func _on_hud_start():
	game_start()


func _on_player_death():
	game_over()
