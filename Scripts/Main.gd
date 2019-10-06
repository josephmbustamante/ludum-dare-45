extends Node2D

onready var player = $Player
onready var enemies = []

onready var ui = $BattleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.input_enabled = false

	var stage = Global.stages[Global.current_stage]
	var health = 0
	for i in range(stage.count):
		var enemy = stage.enemy.instance()
		add_child(enemy)
		var x = rand_range(450, 900)
		var y = rand_range(200, 500)
		enemy.position = Vector2(x, y)
		health += enemy.health
		enemy.connect("enemy_health_changed", ui, "handle_enemy_health_changed")
		enemies.push_back(enemy)

	ui.initialize_enemy_health(health)
	ui.initialize_player_health(PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["current_value"])
	ui.initialize_player_stamina(PlayerVariables.stats[PlayerVariables.PLAYER_STATS.stamina]["current_value"])

	if enemies[0].is_final_boss && player.has_weapon():
		$EnemyBanterBox.set_text(enemies[0].banter_texts[0])
		$EnemyBanterBox.show()
	elif enemies[0].is_final_boss && !player.has_weapon():
		$EnemyBanterBox.set_text(enemies[0].banter_texts[2])
		$EnemyBanterBox.show()
	elif enemies[0].banter_texts.size() > 0:
		$EnemyBanterBox.set_text(enemies[0].banter_texts[randi() % enemies[0].banter_texts.size()])
		$EnemyBanterBox.show()
	else:
		$EnemyBanterBox.hide()
		start_battle()

	if !Global.music_player.playing:
		Global.music_player.play()

func _process(delta: float) -> void:
	if Global.enemy_defeated:
		$VictoryPanel.show()

func _on_VictoryButton_pressed():
	$VictoryPanel.hide()
	Global.enemy_defeated = false
	Global.current_stage += 1
	Global.goto_scene("res://Scenes/LevelUp.tscn")
	queue_free()

func start_battle():
	$EnemyBanterBox.hide()
	for enemy in enemies:
		if enemy.is_final_boss && player.has_weapon():
			if !PlayerVariables.unarmedStyleEnabled:
				PlayerVariables.unarmedStyleEnabled = true
				$EnemyBanterBox.set_text(enemies[0].banter_texts[1])
				$EnemyBanterBox.show()
				return
			# TODO show weapon death animation
			player.handle_hit(10000000)
		enemy.set_target(player)
	player.input_enabled = true