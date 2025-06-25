extends CanvasLayer

signal option_selected(option_id)  # Теперь передаём ID кнопки

func show_dialogue():
	visible = true

@onready var message_label = $Panel/MessageLabel

func show_message(text):
	message_label.text = text
	message_label.show()
	await get_tree().create_timer(2.0).timeout
	message_label.hide()
# Подключается автоматически в редакторе!
func _on_drum_button_pressed():
	emit_signal("option_selected", "drum")
	queue_free()

func _on_spear_button_pressed():
	emit_signal("option_selected", "spear")
	queue_free()

func _on_other_button_pressed():
	emit_signal("option_selected", "other")
	queue_free()

func _on_cancel_button_pressed():
	emit_signal("option_selected", "cancel")
	queue_free()
