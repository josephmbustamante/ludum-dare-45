extends Control

# Declare member variables here. Examples:
var points = 3
var points_remaining = 3

var max_level = 10

var starting_health = 3
var starting_strength = 5
var starting_speed = 1

var health = starting_health
var strength = starting_strength
var speed = starting_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	$Rows/StrengthLevelUpField.set_value(strength)
	$Rows/HealthLevelUpField.set_value(health)
	$Rows/SpeedLevelUpField.set_value(speed)
	
	$Rows/HBoxContainer/RemainingPointsValue.text = str(points_remaining)
		

func decrement(startingLevel, currentLevel):
	if (currentLevel > 1 && currentLevel > startingLevel && points > points_remaining):
		currentLevel -= 1
		points_remaining += 1
		$Rows/HBoxContainer/RemainingPointsValue.text = str(points_remaining)
	return currentLevel

func increment(startingLevel, currentLevel):
	if (currentLevel < max_level && points_remaining > 0):
		currentLevel += 1
		points_remaining -= 1
		$Rows/HBoxContainer/RemainingPointsValue.text = str(points_remaining)
	return currentLevel

# INCREMENT

func _on_StrengthLevelUpField_increase_pressed():
	strength = increment(starting_strength, strength)
	$Rows/StrengthLevelUpField.set_value(strength)

func _on_HealthLevelUpField_increase_pressed():
	health = increment(starting_health, health)
	$Rows/HealthLevelUpField.set_value(health)

func _on_SpeedLevelUpField_increase_pressed():
	speed = increment(starting_speed, speed)
	$Rows/SpeedLevelUpField.set_value(speed)


# DECREMENT
	
func _on_StrengthLevelUpField_decrease_pressed():
	strength = decrement(starting_strength, strength)
	$Rows/StrengthLevelUpField.set_value(strength)

func _on_HealthLevelUpField_decrease_pressed():
	health = decrement(starting_health, health)
	$Rows/HealthLevelUpField.set_value(health)

func _on_SpeedLevelUpField_decrease_pressed():
	speed = decrement(starting_speed, speed)
	$Rows/SpeedLevelUpField.set_value(speed)
