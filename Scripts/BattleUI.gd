extends MarginContainer

onready var player_health_bar = $Rows/Columns/PlayerHealthBar
onready var enemy_health_bar = $Rows/Columns/EnemyHealthBar
var enemy_health = 0

func initialize_player_health(max_health: int):
	player_health_bar.initialize_health_bar(max_health)

func initialize_enemy_health(max_health: int):
	enemy_health = max_health
	enemy_health_bar.initialize_health_bar(max_health)

func handle_player_health_changed(new_health: int):
	player_health_bar.change_health_bar_value(new_health)

func handle_enemy_health_changed(health_lost: int):
	print("handle_enemy_health_changed health_lost", health_lost)
	print("handle_enemy_health_changed original enemy health", enemy_health)
	enemy_health -= health_lost
	print("handle_enemy_health_changed new enemy health", enemy_health)
	enemy_health_bar.change_health_bar_value(enemy_health)
	if enemy_health <= 0:
		Global.enemy_defeated = true
