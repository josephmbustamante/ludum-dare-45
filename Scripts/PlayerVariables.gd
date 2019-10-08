extends Node

enum PLAYER_STATS {
	health,
	strength,
	stamina,
	speed
}

var stats = {
	PLAYER_STATS.health: {
		"start_value": 100,
		"current_value": 100,
		"max_value": 500,
		"increment": 20,
	},
	PLAYER_STATS.strength: {
		"start_value": 1,
		"current_value": 1,
		"max_value": 20,
		"increment": 1,
	},
	PLAYER_STATS.stamina: {
		"start_value": 100.0,
		"current_value": 100.0,
		"max_value": 300.0,
		"increment": 10.0,
	},
	PLAYER_STATS.speed: {
		"start_value": 1,
		"current_value": 1,
		"max_value": 20,
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

func reset_stats():
	for stat in stats:
		stats[stat]["current_value"] = stats[stat]["start_value"]
	deathCount = 0

var unarmedStyleEnabled: bool = false

var deathCount: int = 0
var weapon: int = 0
