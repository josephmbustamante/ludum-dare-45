extends PanelContainer

onready var death_count_text = $MarginContainer/Rows/DeathSection/DeathCountText
onready var rating_text = $MarginContainer/Rows/RatingSection/DeathRatingText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var deaths = PlayerVariables.deathCount
	death_count_text.text = str(deaths)

	if deaths < 2:
		rating_text.set("custom_colors/font_color", Color.blue)
		rating_text.text = "EXCELLENT"
	elif deaths < 4:
		rating_text.set("custom_colors/font_color", Color.forestgreen)
		rating_text.text = "VERY GOOD"
	elif deaths < 6:
		rating_text.set("custom_colors/font_color", Color.greenyellow)
		rating_text.text = "GOOD"
	elif deaths < 8:
		rating_text.set("custom_colors/font_color", Color.yellow)
		rating_text.text = "AVERAGE"
	elif deaths < 10:
		rating_text.set("custom_colors/font_color", Color.orange)
		rating_text.text = "POOR"
	else:
		rating_text.set("custom_colors/font_color", Color.red)
		rating_text.text = "VERY POOR"
