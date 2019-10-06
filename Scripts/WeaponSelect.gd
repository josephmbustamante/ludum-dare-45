extends PanelContainer

var weapon_id = 0

var default_color = Color(0.243137, 0.243137, 0.243137)
var hover_color = Color(0.419608, 0.419608, 0.419608)
var selected_color = Color(0.184314, 0.180392, 0.180392)

var selected: bool = false

signal weapon_selected(weapon_id)

func initialize(weapon_id: int, sprite, name: String, damage: int, speed: int):
	self.weapon_id = weapon_id
	$MarginContainer/Rows/WeaponSprite.texture = sprite
	$MarginContainer/Rows/WeaponName.text = name
	$MarginContainer/Rows/DamageRow/DamageValue.text = str(damage)
	$MarginContainer/Rows/SpeedRow/SpeedValue.text = str(speed)
	set_background_color(default_color)

func unselect():
	selected = false
	set_background_color(default_color)

func set_background_color(color: Color):
	# probably not the ideal way to do this but it works
	# we need to create different styles since all of the weapon selects
	# use the same underlying resource, so changing the color on one
	# changes the color on all of them
	var style = get("custom_styles/panel").duplicate()
	style.set("bg_color", color)
	set("custom_styles/panel", style)

func _on_mouse_entered() -> void:
	if !selected:
		set_background_color(hover_color)

func _on_mouse_exited() -> void:
	if !selected:
		set_background_color(default_color)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			selected = true
			set_background_color(selected_color)
			emit_signal("weapon_selected", weapon_id)
