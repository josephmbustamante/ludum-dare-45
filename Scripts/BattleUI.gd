extends MarginContainer

onready var player_health_bar = $Rows/Columns/PlayerHealthBar
onready var enemy_health_bar = $Rows/Columns/EnemyHealthBar

func initialize_player_health(max_health: int):
	player_health_bar.max_value = max_health
	player_health_bar.value = max_health

func initialize_enemy_health(max_health: int):
	enemy_health_bar.max_value = max_health
	enemy_health_bar.value = max_health

func handle_player_health_changed(new_health: int):
	player_health_bar.value = new_health

func handle_enemy_health_changed(new_health: int):
	enemy_health_bar.value = new_health
