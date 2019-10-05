extends Control

signal increase_pressed()
signal decrease_pressed()

export var fieldName = ""

# min_value is a separate parameter from starting_value because we want to set a min_value
# less than the starting value so there always appears some progress in the bar
func initialize_field(starting_value: int, max_value: int, min_value: int):
	$ProgressBar.max_value = max_value
	$ProgressBar.min_value = min_value
	set_value(starting_value)

func _ready():
	$AbilityNameLabel.text = fieldName + ": "

func _on_Decrease_pressed():
	emit_signal("decrease_pressed")

func _on_Increase_pressed():
	emit_signal("increase_pressed")

func set_value(value: int):
	$ProgressBar.value = value
	$CurrentLevelLabel.text = str(value)
