extends Node2D

onready var player = $Player
onready var enemy

onready var ui = $BattleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.input_enabled = false
	enemy = Global.enemies[Global.current_stage].instance()
	add_child(enemy)

	ui.initialize_player_health(PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["current_value"])
	ui.initialize_enemy_health(enemy.health)
	enemy.connect("enemy_health_changed", ui, "handle_enemy_health_changed")
	if enemy.banter_texts.size() > 0:
		$EnemyBanterBox/Label.text = enemy.banter_texts[randi() % enemy.banter_texts.size()]
		$EnemyBanterBox.show()
	else:
		$EnemyBanterBox.hide()
		start_battle()
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

func start_battle():
	$EnemyBanterBox.hide()
	player.input_enabled = true
	enemy.set_target(player)