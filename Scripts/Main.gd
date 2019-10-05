extends Node2D

onready var player = $Player


onready var ui = $BattleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy = Global.enemies[Global.current_stage].instance()
	add_child(enemy)
	enemy.set_target(player)
	
	ui.initialize_player_health(PlayerVariables.maxHealth)
	ui.initialize_enemy_health(enemy.health)
	enemy.connect("enemy_health_changed", ui, "handle_enemy_health_changed")



func _on_Button_pressed():
	Global.goto_scene("res://Scenes/LevelUp.tscn")
