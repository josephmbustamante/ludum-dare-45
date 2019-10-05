extends Node

enum WEAPON {
	sword
	axe
	unarmed
}

var currentHealth: int = 100;
var maxHealth: int = 100;
var strength: int = 1;
var speed: int = 1;
var weapon: int = 0;

var unarmedStyleEnabled: bool = false;