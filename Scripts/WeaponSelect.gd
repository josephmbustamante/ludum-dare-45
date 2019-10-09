extends PanelContainer

var weapon_id = 0

var default_background = preload("res://Assets/Sprites/uipack-rpg/PNG/panel_beige.png")
var hover_background = preload("res://Assets/Sprites/uipack-rpg/PNG/panel_beigeLight.png")
var selected_background = preload("res://Assets/Sprites/uipack-rpg/PNG/panel_brown.png")

var selected: bool = false

signal weapon_selected(weapon_id)

func initialize(weapon_id: int, sprite, name: String, damage: int, speed: float):
	self.weapon_id = weapon_id
	$MarginContainer/Rows/WeaponSprite.texture = sprite
	$MarginContainer/Rows/WeaponName.text = name
	$MarginContainer/Rows/DamageRow/DamageValue.text = str(damage)
	$MarginContainer/Rows/SpeedRow/SpeedValue.text = str(speed * 10.0) # speed is a multipler -- less than 1 is slower, more than 1 is faster
	set_background_color(default_background)

func unselect():
	selected = false
	set_background_color(default_background)

func set_background_color(background: Resource):
	# probably not the ideal way to do this but it works
	# we need to create different styles since all of the weapon selects
	# use the same underlying resource, so changing the color on one
	# changes the color on all of them
	var style = get("custom_styles/panel").duplicate()
	style.set("texture", background)
	set("custom_styles/panel", style)

func _on_mouse_entered() -> void:
	if !selected:
		set_background_color(hover_background)

func _on_mouse_exited() -> void:
	if !selected:
		set_background_color(default_background)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			selected = true
			set_background_color(selected_background)
			emit_signal("weapon_selected", weapon_id)
