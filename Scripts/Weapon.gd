extends Node2D

export (int) var damage = 20

var group_to_attack: String

func set_group_to_attack(group: String):
	group_to_attack = group

func attack():
	$WeaponSprite/AnimationPlayer.play("WeaponSwing")

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if group_to_attack && body.is_in_group(group_to_attack):
		if body.has_method("handle_hit"):
			body.handle_hit(damage)


