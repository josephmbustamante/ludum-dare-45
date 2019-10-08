extends KinematicBody2D

enum MY_BS_DUPLICATE_WEAPON {
	sword
	axe
	mace
	big_sword
	unarmed
	staff
}

export (int) var health = 100
export (int) var speed = 50
export (int) var strength = 2

export (int) var attack_radius = 30 # how close the enemy needs to be to attack
export (int) var proximity_radius = 20 # how close the enemy should try to get to the player

export (Array) var banter_texts = []
export (MY_BS_DUPLICATE_WEAPON) var weapon_type
export (bool) var is_final_boss = false

var target: PhysicsBody2D = null

var facing_left: bool = false
export var enemy_defeated: bool = false

signal enemy_health_changed(new_health)

func _ready() -> void:
	$Weapon.set_group_to_attack("player")
	$Weapon.set_weapon(weapon_type, strength)
	$AttackCooldown.stop()

func set_target(new_target: PhysicsBody2D):
	target = new_target

func _process(delta: float) -> void:
	var velocity = Vector2()  # The player's movement vector.
	if enemy_defeated:
		return

	if target != null:
		if target.defeated:
			return
		else:
			var distance_to_target = target.global_position - global_position

			# we want the enemy to stand either to the right or left of the player
			var position_to_occupy
			# if we are to the left of the player, set the desired position to be to their left and face right
			if distance_to_target.x > 0:
				position_to_occupy = Vector2(target.global_position.x - proximity_radius, target.global_position.y)
				if facing_left && !$Weapon.is_attacking():
					change_direction()

			# if we are to the right of the player, set the desired position to be to their right and face left
			else:
				position_to_occupy = Vector2(target.global_position.x + proximity_radius, target.global_position.y)
				if !facing_left && !$Weapon.is_attacking():
					change_direction()

			# only keep moving if we haven't reached the target yet
			if (position_to_occupy - global_position).length() > 10:
				velocity = position_to_occupy - global_position

			# if we're close enough to the player, attack, even if we still need to keep moving a bit
			if distance_to_target.length() < attack_radius && $AttackCooldown.is_stopped():
				$Weapon.attack()
				$AttackCooldown.start()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")

	move_and_slide(velocity)

func change_direction():
	facing_left = !facing_left
	scale.x *= -1

func handle_hit(damage: int):
	if enemy_defeated:
		return
	var starting_health = health
	health -= damage
	var health_lost = damage
	if health <= 0:
		health_lost = starting_health

	$AnimationPlayer.play("HitAnimation")
	emit_signal("enemy_health_changed", health_lost)

	# health is the health for all enemies, so this will only
	# get hit if every enemy is dead
	if health <= 0:
		die()

func die():
		$CollisionShape2D.disabled = true
		collision_layer = 0
		collision_mask = 0
		z_index = -1
		$Weapon.hide()
		$AnimatedSprite.rotation = -90
		$AnimatedSprite.playing = false
		modulate = Color.darkgray
		enemy_defeated = true