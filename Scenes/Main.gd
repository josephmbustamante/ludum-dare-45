extends Node2D

onready var player = $Player
onready var enemy = $Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy.set_target(player)