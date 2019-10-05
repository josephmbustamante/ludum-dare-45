extends ProgressBar

var animated_health = 0

var original_color = Color(0.47451, 0.223529, 0.223529)
var flash_color = Color(1, 1, 1)

func initialize_health_bar(max_health: int):
	value = max_health
	max_value = max_health
	animated_health = max_health

func _process(delta: float) -> void:
	value = animated_health

func change_health_bar_value(new_health: int):
	$Tween.interpolate_property(self, "animated_health", animated_health, new_health, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(self, "modulate", original_color, flash_color, 0.5, Tween.TRANS_BOUNCE, Tween.EASE_IN)
	if !$Tween.is_active():
		$Tween.start()
