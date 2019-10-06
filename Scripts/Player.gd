extends KinematicBody2D

onready var health = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["current_value"]
onready var strength = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.strength]["current_value"]
onready var speed = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.speed]["current_value"]
onready var stamina = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.stamina]["current_value"]

# Player stats go betwen 1-10, and if we used that as a speed they would be frustratingly slow.
# Instead, we keep the 1-10 scale, and just have a multiplier here
export (int) var speed_multiplier = 10
export (int) var base_speed = 75
export (bool) var input_enabled = true;
var defeated = false;

export (int) var attack_stamina_cost = 10.0
export (int) var dash_stamina_cost = 20.0
export (int) var dodge_stamina_cost = 20.0
export (int) var stamina_per_second = 10.0
export (float) var stamina_regen = 0

var dash_multiplier = 1

var facing_left: bool = false

signal player_health_changed(new_health)
signal player_stamina_changed(new_stamina)

func has_weapon():
	return PlayerVariables.weapon != Global.WEAPON.unarmed

func _ready() -> void:
	$Weapon.set_group_to_attack("enemy")
	$Weapon.set_weapon(PlayerVariables.weapon, strength)

func _process(delta: float) -> void:
	if stamina < PlayerVariables.stats[PlayerVariables.PLAYER_STATS.stamina]["start_value"]:
		if stamina_regen >= 1.0:
			update_stamina(stamina_regen)
			stamina_regen = 0
		else:
			stamina_regen += 1.0 * delta * stamina_per_second
	if input_enabled:
		var velocity = Vector2()  # The player's movement vector.
		if Input.is_action_pressed("right"):
			velocity.x += 1
		if Input.is_action_pressed("left"):
			velocity.x -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		if Input.is_action_pressed("up"):
			velocity.y -= 1

		if !$DashEffect.is_stopped():
			dash_multiplier = 5
			$Weapon.enable_critical_hit()
		elif !$RollEffect.is_stopped():
			dash_multiplier = 3
			$CollisionShape2D.disabled = true
		else:
			dash_multiplier = 1
			$Weapon.disable_critical_hit()
			$CollisionShape2D.disabled = false

		if velocity.length() > 0:
			velocity = velocity.normalized() * (base_speed + (speed * speed_multiplier)) * dash_multiplier
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")

		if velocity.x < 0 && !facing_left:
			scale.x *= -1
			facing_left = true
		elif velocity.x > 0 && facing_left:
			scale.x *= -1
			facing_left = false

		if Input.is_action_just_pressed("dash")  && $DashCooldown.is_stopped() && stamina >= dash_stamina_cost:
			update_stamina(-dash_stamina_cost)
			$DashCooldown.start()
			$DashEffect.start()
			$Weapon.enable_critical_hit()

		if Input.is_action_just_pressed("attack") && $AttackCooldown.is_stopped() && stamina >= attack_stamina_cost:
			update_stamina(-attack_stamina_cost)
			$Weapon.attack()
			$AttackCooldown.start(0.5)

		if Input.is_action_just_pressed("dodge") && $RollCooldown.is_stopped() && $AttackCooldown.is_stopped() && stamina >= dodge_stamina_cost:
			update_stamina(-dodge_stamina_cost)
			$RollCooldown.start()
			$RollEffect.start()

		move_and_slide(velocity)

func handle_hit(damage: int):
	update_health(damage)
	$AnimationPlayer.play("HitAnimation")

	if health <= 0:
		defeated = true
		input_enabled = false
		$Weapon.hide()
		$AnimatedSprite.rotation = -90
		$AnimatedSprite.playing = false
		$DeathTimer.start()

func finish_death_transition():
	Global.player_died()
	Global.goto_scene("res://Scenes/WeaponPickerScreen.tscn")
	queue_free()

func update_health(damage: int):
	health -= damage
	emit_signal("player_health_changed", health)

func update_stamina(stamina_change: float):
	stamina += stamina_change * 1.0
	emit_signal("player_stamina_changed", stamina)


