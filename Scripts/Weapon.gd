extends Node2D

export (int) var damage = 0
export (int) var base_speed = 1
export (int) var base_reach = 1
var base_x_offset: int = 20

var group_to_attack: String

var weapon_config = {
	Global.WEAPON.sword: {
		"speed": 1,
		"sprite": preload("res://Assets/Sprites/weapon_regular_sword.png"),
		"damage": 20,
		"reach": 0
	},
	Global.WEAPON.mace: {
		"speed": 0.5,
		"sprite": preload("res://Assets/Sprites/weapon_mace.png"),
		"damage": 30,
		"reach": -10
	}
}

func set_group_to_attack(group: String):
	group_to_attack = group

func set_weapon(weapon_id: int):
	var w = weapon_config[weapon_id]
	print(weapon_id, w)
	$WeaponSprite/AnimationPlayer.playback_speed = base_speed * w["speed"]
	$WeaponSprite.texture = w["sprite"]
	# For now, just implementing reach by x-shifting the hit box
	$WeaponHitBox/CollisionShape2D.position.x = base_x_offset + w["reach"]
	damage = w["damage"]

func attack():
	$WeaponSprite/AnimationPlayer.play("WeaponSwing")

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if group_to_attack && body != null && body.is_in_group(group_to_attack):
		if body.has_method("handle_hit"):
			body.handle_hit(damage)


