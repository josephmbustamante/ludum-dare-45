extends PanelContainer

signal defeat_button_pressed

func _on_defeat_button_pressed() -> void:
	emit_signal("defeat_button_pressed")
