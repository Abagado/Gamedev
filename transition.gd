extends CanvasLayer

signal transition_finished

func _ready():
	# Явно включаем видимость
	visible = true
	$ColorRect.visible = true

func fade_in():
	var duration = 1.5
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1.0, duration)
	await tween.finished
	emit_signal("transition_finished")
	print("Tween completed")
