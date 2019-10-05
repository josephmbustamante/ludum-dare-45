extends Node2D

onready var player = $Player
onready var enemy = $Enemy

onready var ui = $BattleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.initialize_player_health(PlayerVariables.maxHealth)
	ui.initialize_enemy_health(enemy.health)

	enemy.set_target(player)
