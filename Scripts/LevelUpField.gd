extends Control

signal increase_pressed()
signal decrease_pressed()

export var fieldName = ""

func _ready():
	$Ability.text = fieldName + ": "

func _on_Decrease_pressed():
	emit_signal("decrease_pressed")

func _on_Increase_pressed():
	emit_signal("increase_pressed")

func set_value(value):
	$ProgressBar.value = value
