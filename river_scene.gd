extends Node2D

@onready var music_player = $MusicPlayer
@onready var river_sound = $RiverSound
@onready var birds_sound = $BirdsSound

func _ready():
	var track = load("res://audio/music/river_music.wav")
	music_player.stream = track
	music_player.play()
	var river_audio = load("res://audio/sfx/river_sound.wav")
	river_sound.stream = river_audio
	river_sound.play()
	var birds_audio = load("res://audio/sfx/birds.wav")
	music_player.stream = track
	music_player.play()
	var sprite := $Background/Sprite2D
	var texture : Texture2D = sprite.texture
	var camera = $Boat/Camera2D
	if texture == null:
		print("Нет текстуры у спрайта!")
		return
	
	# Размеры экрана и текстуры
	var screen_size = get_viewport().get_visible_rect().size
	var texture_size = texture.get_size()
	
	# Вычисляем масштаб по высоте
	var scale_factor = screen_size.y / texture_size.y
	sprite.scale = Vector2(scale_factor, scale_factor)
	camera.limit_left = 0
	camera.limit_top = 0
	var scaled_width = sprite.texture.get_width() * sprite.scale.x
	camera.limit_right = int(scaled_width) - int(screen_size.x / 2)
	camera.limit_bottom = int(texture_size.y)
	# Центрируем фон по левому верхнему углу
	sprite.position = Vector2.ZERO
	
