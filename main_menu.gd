extends Control

@onready var music_player = $MusicPlayer

func _ready():
	var track = load("res://audio/music/main_menu.wav")
	music_player.stream = track
	music_player.play()


func _on_settings_button_pressed() -> void:
	var settings_menu = load("res://settings_menu.tscn").instantiate()
	get_tree().root.add_child(settings_menu)  # Добавляем поверх всего
