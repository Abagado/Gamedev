extends CanvasLayer

@onready var music_slider = $Panel/MusicSlider
@onready var sfx_slider = $Panel/SFXSlider
@onready var ambient_slider = $Panel/AmbientSlider

func _ready():
	# Устанавливаем текущие значения громкости
	music_slider.value = SoundManager.music_volume
	sfx_slider.value = SoundManager.sfx_volume
	ambient_slider.value = SoundManager.ambient_volume

func _on_close_button_pressed():
	queue_free()  # Закрываем окно


func _on_music_slider_value_changed(value: float) -> void:
	SoundManager.set_music_volume(value)


func _on_ambient_slider_value_changed(value: float) -> void:
	SoundManager.set_ambient_volume(value)


func _on_sfx_slider_value_changed(value: float) -> void:
	SoundManager.set_sfx_volume(value)
