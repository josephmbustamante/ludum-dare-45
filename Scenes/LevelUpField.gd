extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var maxLevel = 10
#var currentLevel = 3
#var points = 3
#var points_left = 3

signal increase_pressed()
signal decrease_pressed()

export var fieldName = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ability.text = fieldName + ": "

func _on_Decrease_pressed():
	emit_signal("decrease_pressed")
#	if (currentLevel > 1 && points > points_left):
#		currentLevel -= 1
#		points_left += 1
#		emit_signal("points_left_changed", points_left)
#		update_text()


func _on_Increase_pressed():
	emit_signal("increase_pressed")
#	if (currentLevel < maxLevel && points_left > 0):
#		currentLevel += 1
#		points_left -= 1
#		emit_signal("points_left_changed", points_left)
#		update_text()

func set_value(value):
	$ProgressBar.value = value
		
#func update_text():
#	$ProgressBar.value = currentLevel
#
#
#func _on_LevelUp_health_changed(new_health):
#	print("_on_LevelUp_health_changed", new_health)
#	$ProgressBar.value = new_health
#
#
#func _on_LevelUp_strength_changed(new_strength):
#	print("_on_LevelUp_strength_changed", new_strength)
#	$ProgressBar.value = new_strength
