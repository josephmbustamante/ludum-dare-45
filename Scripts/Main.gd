extends Node2D

onready var player = $Player
onready var enemies = []
var total_enemy_health = 0

onready var ui = $BattleUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.input_enabled = false

	var stage = Global.stages[Global.current_stage]
	for i in range(stage.count):
		var enemy = stage.enemy.instance()
		add_child(enemy)
		var x = rand_range(450, 900)
		var y = rand_range(200, 500)
		enemy.position = Vector2(x, y)
		total_enemy_health += enemy.health
		enemy.connect("enemy_health_changed", ui, "handle_enemy_health_changed")
		enemy.connect("enemy_health_changed", self, "handle_enemy_defeated")
		enemies.push_back(enemy)

	ui.initialize_enemy_health(total_enemy_health)
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

func handle_enemy_defeated(health_change):
	total_enemy_health -= health_change
	if total_enemy_health <= 0:
		$VictoryPanel.show()

func handle_player_defeated():
	$DefeatPanel.show()

func _on_VictoryButton_pressed():
	$VictoryPanel.hide()
	Global.current_stage += 1
	if enemies[0].is_final_boss:
		Global.goto_scene("res://Scenes/FinalVictoryScreen.tscn")
	else:
		Global.goto_scene("res://Scenes/LevelUp.tscn")
	queue_free()

func _on_DefeatPanel_defeat_button_pressed() -> void:
	$DefeatPanel.hide()
	Global.current_stage = 0
	Global.player_died()
	Global.goto_scene("res://Scenes/WeaponPickerScreen.tscn")
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
			enemy.enemy_defeated = true # TODO find a better way to lock the wizard from moving
			player.show_execution()
		else:
			player.input_enabled = true
		enemy.set_target(player)
