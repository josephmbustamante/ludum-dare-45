extends KinematicBody2D

export (int) var health = 100
export (int) var speed = 50
export (int) var hit_radius = 30

var target: PhysicsBody2D = null

var facing_left: bool = false

func _ready() -> void:
	$Weapon.set_group_to_attack("player")
	$AttackCooldown.stop()

func set_target(new_target: PhysicsBody2D):
	target = new_target

func _process(delta: float) -> void:
	var velocity = Vector2()  # The player's movement vector.

	if target != null:
		var distance_to_target = target.global_position - global_position
		# only keep moving if we haven't reached the target yet
		if distance_to_target.length() >= hit_radius:
			velocity = target.global_position - global_position
		elif $AttackCooldown.is_stopped():
			$Weapon.attack()
			$AttackCooldown.start()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")

	if velocity.x < 0 && !facing_left:
		scale.x *= -1
		facing_left = true
	elif velocity.x > 0 && facing_left:
		scale.x *= -1
		facing_left = false

	move_and_slide(velocity)

func handle_hit(damage: int):
	health -= damage
	print("Enemy was hit, new health: ", health)
	if health <= 0:
		queue_free()
