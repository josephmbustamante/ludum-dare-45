extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

onready var menuButton = $VBoxContainer/HBoxContainer/VBoxContainer/MenuButton
onready var startButton = $VBoxContainer/HBoxContainer/VBoxContainer2/Button

func _ready():
	var popup = menuButton.get_popup()
	popup.connect("id_pressed", self, "weapon_menu_selection_made")
	var mb = menuButton.get_popup()
	mb.add_item("Sword", Global.WEAPON.sword)
	mb.add_item("Mace", Global.WEAPON.mace)
	if (PlayerVariables.unarmedStyleEnabled):
		mb.add_item("Start with nothing", Global.WEAPON.unarmed)

func _on_Start_Button_pressed():
	print("Button pressed")
	Global.goto_scene("res://Scenes/Main.tscn")

func weapon_menu_selection_made(id):
	print(id)
	PlayerVariables.weapon = id
	startButton.disabled = false