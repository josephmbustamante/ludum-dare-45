extends PanelContainer

signal banter_box_fight_clicked

func set_text(text: String):
	$Rows/Label.text = text

func _on_fight_button_pressed():
	emit_signal("banter_box_fight_clicked")
