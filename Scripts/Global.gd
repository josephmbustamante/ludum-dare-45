extends Node

var current_scene = null

enum WEAPON {
	sword
	axe
	mace
	big_sword
	unarmed
}

var weapon_config = {
	WEAPON.sword: {
		"speed": 1,
		"sprite": preload("res://Assets/Sprites/weapon_regular_sword.png"),
		"damage": 20,
		"reach": 0,
		"sound": "slash",
		"name": "Sword",
		"restricted": false
	},
	WEAPON.axe: {
		"speed": 0.75,
		"sprite": preload("res://Assets/Sprites/weapon_axe.png"),
		"damage": 25,
		"reach": -5,
		"sound": "slash",
		"name": "Axe",
		"restricted": false
	},
	WEAPON.mace: {
		"speed": 0.5,
		"sprite": preload("res://Assets/Sprites/weapon_mace.png"),
		"damage": 30,
		"reach": -10,
		"sound": "bludgeon",
		"name": "Mace",
		"restricted": false
	},
	WEAPON.big_sword: {
		"speed": 0.25,
		"sprite": preload("res://Assets/Sprites/weapon_anime_sword.png"),
		"damage": 50,
		"reach": 10,
		"sound": "slash",
		"name": "Big Sword",
		"restricted": false
	},
	WEAPON.unarmed: {
		"speed": 0.25,
		"sprite": preload("res://Assets/Sprites/weapon_anime_sword.png"),
		"damage": 50,
		"reach": 10,
		"sound": "slash",
		"name": "Unarmed",
		"restricted": true
	},
}
var stages = [
	{ "enemy": load("res://Scenes/Enemies/BigZombie.tscn"), "count": 1 },
	{ "enemy": load("res://Scenes/Enemies/Ogre.tscn"), "count": 1 },
	{ "enemy": load("res://Scenes/Enemies/BigDemon.tscn"), "count": 1 },
	{ "enemy": load("res://Scenes/Enemies/Imp.tscn"), "count": 10 },
]

var enemy_defeated = false

var current_stage = 0
var music_player: AudioStreamPlayer

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	if !music_player:
		music_player = AudioStreamPlayer.new()
		music_player.volume_db = -6
		music_player.stream = load("res://Assets/Music/ld45_theme.wav")
		self.add_child(music_player)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

func player_died():
	PlayerVariables.deathCount += 1
	music_player.stop()