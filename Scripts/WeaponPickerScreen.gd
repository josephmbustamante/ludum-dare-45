extends MarginContainer

var weapon_select = preload("res://Scenes/WeaponSelect.tscn")

onready var startButton = $Rows/CenterContainer/Button

func _ready():
	for weapon in Global.WEAPON:
		var weapon_config = Global.weapon_config[Global.WEAPON[weapon]]
		if !weapon_config["restricted"]:
			create_weapon_select(Global.WEAPON[weapon], weapon_config["sprite"], weapon_config["name"], weapon_config["damage"], weapon_config["speed"])

	if (PlayerVariables.unarmedStyleEnabled):
		var weapon_config = Global.weapon_config[Global.WEAPON.unarmed]
		create_weapon_select(Global.WEAPON.unarmed, weapon_config["sprite"], weapon_config["name"], weapon_config["damage"], weapon_config["speed"])

	# This line has no text / is invisible until the player dies once
	if (PlayerVariables.deathCount > 0):
		$Rows/DeathCountText.text = str("YOU HAVE DIED %s TIMES", PlayerVariables.deathCount)

func create_weapon_select(weapon_id: int, sprite, name: String, damage: int, speed: int):
	# create a weapon select for each weapon and add it to the weapon select section
	var select = weapon_select.instance()
	$Rows/WeaponColumns.add_child(select)
	select.initialize(weapon_id, sprite, name, damage, speed)
	# send a message that the weapon has been selected
	select.connect("weapon_selected", self, "weapon_menu_selection_made")

func _on_Start_Button_pressed():
	print("Button pressed")
	Global.goto_scene("res://Scenes/Main.tscn")

func weapon_menu_selection_made(id):
	print(id)
	PlayerVariables.weapon = id
	startButton.disabled = false