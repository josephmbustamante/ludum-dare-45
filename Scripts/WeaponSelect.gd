extends VBoxContainer

var weapon_id = 0

signal weapon_selected(weapon_id)

func initialize(weapon_id: int, sprite, name: String, damage: int, speed: int):
	self.weapon_id = weapon_id
	$WeaponSprite.texture = sprite
	$WeaponName.text = name
	$DamageRow/DamageValue.text = str(damage)
	$SpeedRow/SpeedValue.text = str(speed)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("weapon_selected", weapon_id)

