extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

onready var menuButton = $VBoxContainer/HBoxContainer/VBoxContainer/MenuButton
onready var startButton = $VBoxContainer/HBoxContainer/VBoxContainer2/Button

var starting_message = "You've died. But rather than send you immediately to the afterlife, the gods have chosen you for reincarnation to fight in their arena. Equip yourself, for battle looms near."
var died_in_arena_message = "You've died %s times. Equip yourself, for battle looms near."

func _ready():
	var popup = menuButton.get_popup()
	popup.connect("id_pressed", self, "weapon_menu_selection_made")
	var mb = menuButton.get_popup()
	for weapon in Global.WEAPON:
		var wc = Global.weapon_config[Global.WEAPON[weapon]]
		if !wc["restricted"]:
			mb.add_item(Global.weapon_config[Global.WEAPON[weapon]]["name"], Global.WEAPON[weapon])

	if (PlayerVariables.unarmedStyleEnabled):
		mb.add_item("Start with nothing", Global.WEAPON.unarmed)
	if (PlayerVariables.deathCount > 0):
		$VBoxContainer/RichTextLabel.text = died_in_arena_message % PlayerVariables.deathCount
	else:
		$VBoxContainer/RichTextLabel.text = starting_message

func _on_Start_Button_pressed():
	print("Button pressed")
	Global.goto_scene("res://Scenes/Main.tscn")

func weapon_menu_selection_made(id):
	print(id)
	PlayerVariables.weapon = id
	startButton.disabled = false