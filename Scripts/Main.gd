extends Node2D

onready var player = $Player

onready var ui = $BattleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var stage = Global.stages[Global.current_stage]
	var health = 0
	for i in range(stage.count):
		var enemy = stage.enemy.instance()
		add_child(enemy)
		enemy.set_target(player)
		var x = rand_range(450, 900)
		var y = rand_range(10, 600)
		enemy.position = Vector2(x, y)
		health += enemy.health
		enemy.connect("enemy_health_changed", ui, "handle_enemy_health_changed")

	ui.initialize_enemy_health(health)
	ui.initialize_player_health(PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["current_value"])

	if !Global.music_player.playing:
		Global.music_player.play()

func _process(delta: float) -> void:
	if Global.enemy_defeated:
		$VictoryButton.show()
		$VictoryMessage.show()

func _on_VictoryButton_pressed():
	$VictoryButton.hide()
	$VictoryMessage.hide()
	Global.enemy_defeated = false
	Global.current_stage += 1
	Global.goto_scene("res://Scenes/LevelUp.tscn")
	queue_free()
