extends Node2D  # Или ваш основной тип сцены

# 1. Предзагрузка сцен
@onready var dialogue_box = preload("res://dialogue_box.tscn")
@onready var dice_game = preload("res://dice_game.tscn")
@onready var music_player = $MusicPlayer
# 2. Правильное получение ссылок на ноды
@onready var merchant_interaction = $MerchantInteraction

func _ready():
	var track = load("res://audio/music/trader_music.mp3")
	music_player.stream = track
	music_player.play()
	# 3. Проверка существования ноды перед подключением
	if merchant_interaction:
		merchant_interaction.connect("item_selected", _on_item_selected)
	else:
		print("Ошибка: MerchantInteractionProxy не найден! Проверьте путь: ", 
			  get_tree().current_scene.get_path_to(merchant_interaction))

func _on_item_selected(item_name):
	match item_name:
		"drum":
			var game_instance = dice_game.instantiate()
			add_child(game_instance)
		"other":
			print("Показаны другие товары")
		"cancel":
			print("Диалог закрыт")
