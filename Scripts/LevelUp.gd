extends Control

# Declare member variables here. Examples:
var points = 3
var points_remaining = 3

onready var starting_strength = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.strength]["start_value"]
onready var starting_health = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["start_value"]
onready var starting_speed = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.speed]["start_value"]

onready var current_strength = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.strength]["current_value"]
onready var current_health = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["current_value"]
onready var current_speed = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.speed]["current_value"]

onready var max_strength = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.strength]["max_value"]
onready var max_health = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["max_value"]
onready var max_speed = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.speed]["max_value"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$Rows/StrengthLevelUpField.set_value(current_strength)
	$Rows/HealthLevelUpField.set_value(current_health)
	$Rows/SpeedLevelUpField.set_value(current_speed)

	$Rows/HBoxContainer/RemainingPointsValue.text = str(points_remaining)

func _on_Confirm_pressed():
	Global.goto_scene("res://Scenes/Main.tscn")

# INCREMENT

func _on_StrengthLevelUpField_increase_pressed():
	current_strength = increment(max_strength, current_strength)
	PlayerVariables.set_player_stat_current(PlayerVariables.PLAYER_STATS.strength, current_strength)
	$Rows/StrengthLevelUpField.set_value(current_strength)

func _on_HealthLevelUpField_increase_pressed():
	current_health = increment(max_health, current_health)
	PlayerVariables.set_player_stat_current(PlayerVariables.PLAYER_STATS.health, current_health)
	$Rows/HealthLevelUpField.set_value(current_health)

func _on_SpeedLevelUpField_increase_pressed():
	current_speed = increment(max_speed, current_speed)
	PlayerVariables.set_player_stat_current(PlayerVariables.PLAYER_STATS.speed, current_speed)
	$Rows/SpeedLevelUpField.set_value(current_speed)


# DECREMENT

func _on_StrengthLevelUpField_decrease_pressed():
	current_strength = decrement(starting_strength, current_strength)
	PlayerVariables.set_player_stat_current(PlayerVariables.PLAYER_STATS.strength, current_strength)
	$Rows/StrengthLevelUpField.set_value(current_strength)

func _on_HealthLevelUpField_decrease_pressed():
	current_health = decrement(starting_health, current_health)
	PlayerVariables.set_player_stat_current(PlayerVariables.PLAYER_STATS.health, current_health)
	$Rows/HealthLevelUpField.set_value(current_health)

func _on_SpeedLevelUpField_decrease_pressed():
	current_speed = decrement(starting_speed, current_speed)
	PlayerVariables.set_player_stat_current(PlayerVariables.PLAYER_STATS.speed, current_speed)
	$Rows/SpeedLevelUpField.set_value(current_speed)

# INTERNAL HELPERS

func decrement(starting_level, current_level):
	if (current_level > 1 && current_level > starting_level && points > points_remaining):
		current_level -= 1
		points_remaining += 1
		$Rows/HBoxContainer/RemainingPointsValue.text = str(points_remaining)
	return current_level

func increment(max_level, current_level):
	if (current_level < max_level && points_remaining > 0):
		current_level += 1
		points_remaining -= 1
		$Rows/HBoxContainer/RemainingPointsValue.text = str(points_remaining)
	return current_level
