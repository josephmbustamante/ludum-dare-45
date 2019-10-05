extends KinematicBody2D

onready var health = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.health]["current_value"]
onready var strength = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.strength]["current_value"]
onready var speed = PlayerVariables.stats[PlayerVariables.PLAYER_STATS.speed]["current_value"]

# Player stats go betwen 1-10, and if we used that as a speed they would be frustratingly slow.
# Instead, we keep the 1-10 scale, and just have a multiplier here
var speed_multiplier = 50

var facing_left: bool = false

signal player_health_changed(new_health)

func _ready() -> void:
	$Weapon.set_group_to_attack("enemy")
	$Weapon.set_weapon(PlayerVariables.weapon, strength)

func _process(delta: float) -> void:
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * (speed * speed_multiplier)
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")

	if velocity.x < 0 && !facing_left:
		scale.x *= -1
		facing_left = true
	elif velocity.x > 0 && facing_left:
		scale.x *= -1
		facing_left = false

	if Input.is_action_just_pressed("click"):
		$Weapon.attack()

	move_and_slide(velocity)

func handle_hit(damage: int):
	health -= damage
	$AnimationPlayer.play("HitAnimation")
	emit_signal("player_health_changed", health)
	if health <= 0:
		Global.player_died()
		Global.goto_scene("res://Scenes/WeaponPickerScreen.tscn")
		queue_free()



