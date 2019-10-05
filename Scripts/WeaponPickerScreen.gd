extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

onready var menuButton = $HBoxContainer/VBoxContainer/MenuButton
onready var startButton = $HBoxContainer/VBoxContainer2/Button

func _ready():
	var popup = menuButton.get_popup()
	popup.connect("id_pressed", self, "weapon_menu_selection_made")
	if (PlayerVariables.unarmedStyleEnabled):
		menuButton.get_popup().add_item("unarmed", PlayerVariables.WEAPON.unarmed)

func _on_Start_Button_pressed():
	print("Button pressed")
	Global.goto_scene("res://Scenes/Main.tscn")

func weapon_menu_selection_made(id):
	PlayerVariables.weapon = id
	startButton.disabled = false