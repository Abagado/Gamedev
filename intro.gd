extends CanvasLayer

@export var images: Array[Texture2D] = []
@export var texts: Array[String] = []
@export var display_time: float = 3.0
@export var fade_time: float = 1.0

var current_index = 0
var can_advance = false

@onready var texture_rect = $TextureRect
@onready var label = $Panel/Label
@onready var fade_rect = $ColorRect
@onready var timer = $Timer
@onready var music_player = $MusicPlayer
@onready var heart = $Heart
@onready var crack = $Crack

func _ready():
	var track = load("res://audio/music/intro_music.wav")
	music_player.stream = track
	music_player.play()
	var track2 = load("res://audio/sfx/heartbeat.wav")
	music_player.stream = track
	music_player.play()
	assert(images.size() == texts.size(), "Количество картинок и текстов должно совпадать")
	show_slide(0)
	
	# Разрешаем переключение после первой анимации
	await get_tree().create_timer(fade_time).timeout
	can_advance = true

func show_slide(index):
	current_index = index
	texture_rect.texture = images[index]
	label.text = texts[index]
	
	# Запускаем таймер для автоматического перехода
	timer.start(display_time)

func _on_timer_timeout():
	if can_advance:
		next_slide()

func next_slide():
	can_advance = false
	
	# Затемнение
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, fade_time/2)
	await tween.finished
	
	# Смена контента
	current_index = (current_index + 1) % images.size()
	
	if current_index == 2:
		$Crack.play()
	if current_index == 0:
		end_intro()
		return
		
	show_slide(current_index)
	
	# Появление
	tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, fade_time/2)
	await tween.finished
	
	can_advance = true

func end_intro():
	# Переход к основной игре
	get_tree().change_scene_to_file("res://river_scene.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept") and can_advance:
		next_slide()
