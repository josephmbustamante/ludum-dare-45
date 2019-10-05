extends Node

enum PLAYER_STATS {
	health,
	strength,
	speed
}

var stats = {
	PLAYER_STATS.health: {
		"start_value": 100,
		"current_value": 100,
		"max_value": 300,
		"increment": 20,
	},
	PLAYER_STATS.strength: {
		"start_value": 1,
		"current_value": 1,
		"max_value": 10,
		"increment": 1,
	},
	PLAYER_STATS.speed: {
		"start_value": 1,
		"current_value": 1,
		"max_value": 10,
		"increment": 1,
	}
}
func get_player_stat_start(stat: int) -> int:
	return stats[stat]["start_value"]

func get_player_stat_current(stat: int) -> int:
	return stats[stat]["current_value"]

func get_player_stat_max(stat: int) -> int:
	return stats[stat]["max_value"]

func set_player_stat_current(stat: int, new_value: int):
	stats[stat]["current_value"] = new_value

var unarmedStyleEnabled: bool = false

var deathCount: int = 0
var weapon: int = 0
