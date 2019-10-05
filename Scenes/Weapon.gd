extends Sprite

func attack():
	$AnimationPlayer.play("WeaponSwing")

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("enemy"):
		if body.has_method("handle_hit"):
			body.handle_hit()


