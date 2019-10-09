extends Node2D

export (int) var damage = 0
export (int) var strength_multiplier = 2 # each point of strength adds this much damage

export (int) var base_speed = 1
export (float) var damage_multiplier = 1

var base_x_offset: int = 20
var sounds
var critical_hit = 1.0

var group_to_attack: String

var unarmed = false

var sounds_config = {
	"slash": [load("res://Assets/Sounds/Slash1.wav"), load("res://Assets/Sounds/Slash2.wav"), load("res://Assets/Sounds/Slash3.wav")],
	"bludgeon": [load("res://Assets/Sounds/Bludgeon1.wav"), load("res://Assets/Sounds/Bludgeon2.wav"), load("res://Assets/Sounds/Bludgeon3.wav")]
}
var swing_sound = load("res://Assets/Sounds/swing.wav")

var audio_player: AudioStreamPlayer = null
func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	self.add_child(audio_player)

func set_group_to_attack(group: String):
	group_to_attack = group

func set_weapon(weapon_id: int, strength: int):
	unarmed = weapon_id == Global.WEAPON.unarmed
#	if unarmed:
#		$WeaponSprite.position.y += 10
	var w = Global.weapon_config[weapon_id]
	print(weapon_id, w)
	$WeaponSprite/AnimationPlayer.playback_speed = base_speed * w["speed"]
	$WeaponSprite.texture = w["sprite"]
	# For now, just implementing reach by x-shifting the hit box
	$WeaponHitBox/CollisionShape2D.position.x = base_x_offset + w["reach"]
	damage = (w["damage"] + (strength * strength_multiplier))*damage_multiplier
	sounds = sounds_config[w["sound"]]

func enable_critical_hit():
	critical_hit = 1.75
#
func disable_critical_hit():
	critical_hit = 1.0

func is_attacking() -> bool:
	return $WeaponSprite/AnimationPlayer.is_playing()

func attack():
	if unarmed:
		$WeaponSprite/AnimationPlayer.play("Punch")
	else:
		$WeaponSprite/AnimationPlayer.play("WeaponSwing")

	audio_player.stream = swing_sound
	audio_player.play()

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if group_to_attack && body != null && body.is_in_group(group_to_attack):
		if body.has_method("handle_hit"):
			audio_player.stream = sounds[randi() % sounds.size()]
			audio_player.play()
			body.handle_hit(damage * critical_hit)


