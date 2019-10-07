extends MarginContainer

onready var player_health_bar = $Rows/Columns/PlayerBars/PlayerHealthBar
onready var player_stamina_bar = $Rows/Columns/PlayerBars/PlayerStaminaBar
onready var enemy_health_bar = $Rows/Columns/EnemyHealthBar
var enemy_health = 0

func initialize_player_health(max_health: int):
	player_health_bar.initialize_health_bar(max_health)

func initialize_player_stamina(stamina: int):
	player_stamina_bar.initialize_health_bar(stamina)

func initialize_enemy_health(max_health: int):
	enemy_health = max_health
	enemy_health_bar.initialize_health_bar(max_health)

func handle_player_stamina_changed(new_stamina: float):
	player_stamina_bar.change_health_bar_value(new_stamina)

func handle_player_health_changed(new_health: int):
	player_health_bar.change_health_bar_value(new_health)

func handle_enemy_health_changed(health_lost: int):
	enemy_health -= health_lost
	enemy_health_bar.change_health_bar_value(enemy_health)
