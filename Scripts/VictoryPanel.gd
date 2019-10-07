extends PanelContainer

signal victory_button_pressed

func _on_VictoryButton_pressed() -> void:
	emit_signal("victory_button_pressed")
