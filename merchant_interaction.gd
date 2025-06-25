extends Area2D

@onready var question_mark = $QuestionMark
@onready var dialogue_box = preload("res://dialogue_box.tscn")
@onready var dice_game_scene = preload("res://dice_game.tscn")
var player_in_range = false

func _ready():
	if has_node("QuestionMark"):
		question_mark.visible = false

func _on_body_entered(body):
	if body.name == "player":
		player_in_range = true
		question_mark.visible = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_range = false
		question_mark.visible = false

func _input(event):
	if player_in_range and event.is_action_pressed("ui_accept"):
		show_dialogue()

func show_dialogue():
	var db = dialogue_box.instantiate()
	get_parent().add_child(db)
	db.show_dialogue()
	db.connect("option_selected", _on_dialogue_choice)

# НОВЫЕ ФУНКЦИИ, КОТОРЫХ НЕ ХВАТАЛО
func start_dice_game(item_name):
	var dice_game = dice_game_scene.instantiate()
	dice_game.item_to_win = item_name
	get_parent().add_child(dice_game)

func show_message(text):
	# Создаем временное всплывающее сообщение
	var label = Label.new()
	label.text = text
	label.modulate = Color.WHITE
	add_child(label)
	
# Обработчик выбора в диалоге
func _on_dialogue_choice(option_id):
	var db = get_parent().get_node("DialogueBox")
	match option_id:
		"drum":
			show_message("Отличный выбор! Сыграем в кости за барабан.")
			start_dice_game("Барабан")
		"spear":
			show_message("Копьё? Сыграем в кости за него!")
			start_dice_game("Копьё")
		"other":
			show_message("Стражу леса ничего другого не нужно.")
		"cancel":
			show_message("Заходи ещё, если передумаешь!")
