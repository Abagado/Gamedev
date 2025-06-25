extends Node

var music_volume: float = 0.5
var sfx_volume: float = 0.5
var ambient_volume: float = 0.5

func set_music_volume(value: float):
	music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value/100))

func set_sfx_volume(value: float):
	sfx_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func set_ambient_volume(value: float):
	ambient_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), linear_to_db(value))
