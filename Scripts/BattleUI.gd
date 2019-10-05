extends MarginContainer

func handle_player_health_changed(health: int):
	print(health)
	$Rows/Columns/PlayerHealthBar.value = health

func handle_enemy_health_changed(health: int):
	$Rows/Columns/EnemyHealthBar.value = health
