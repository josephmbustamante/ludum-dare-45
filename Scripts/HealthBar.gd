extends ProgressBar

var animated_health = 0

var original_modulate = Color(1, 1, 1)
var flash_modulate = Color(2, 2, 2)

func initialize_health_bar(max_health: int):
	value = max_health
	max_value = max_health
	animated_health = max_health

func _process(delta: float) -> void:
	value = animated_health

func change_health_bar_value(new_health: int):
	$Tween.interpolate_property(self, "animated_health", animated_health, new_health, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(self, "modulate", original_modulate, flash_modulate, 0.25, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.interpolate_property(self, "modulate", flash_modulate, original_modulate, 0.25, Tween.TRANS_QUAD, Tween.EASE_IN, 0.25)
	if !$Tween.is_active():
		$Tween.start()
