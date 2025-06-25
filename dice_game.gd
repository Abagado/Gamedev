extends CanvasLayer

var item_to_win = ""
var is_rolling = false
@onready var dice_sprite = $Panel/DiceSprite

func _ready():
	# Настройка текста
	$Panel/Label.text = "Выиграй %s!\nВыбери ставку:" % item_to_win
	$Panel/Label.position = Vector2($Panel.size.x/2.5, 20)
	
	# Позиционирование элементов
	dice_sprite.position = $Panel.size * 0.5
	dice_sprite.hide()
	
	# Подключение кнопок
	$Panel/ButtonHigh.pressed.connect(_on_high_pressed)
	$Panel/ButtonLow.pressed.connect(_on_low_pressed)
	$Panel/CloseButton.pressed.connect(_on_close_pressed)

func _on_high_pressed():
	if !is_rolling:
		$DiceSound.play()
		start_roll(">3")

func _on_low_pressed():
	if !is_rolling:
		$DiceSound.play()
		start_roll("<=3")

func _on_close_pressed():
	queue_free()  # Закрытие мини-игры

func start_roll(bet_type):
	is_rolling = true
	$Panel/Label.text = "Кости бросаются..."
	dice_sprite.show()
	dice_sprite.play("roll")
	
	var tween = create_tween()
	tween.tween_property(dice_sprite, "position:y", 
		dice_sprite.position.y - 50, 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(dice_sprite, "position:y", 
		dice_sprite.position.y, 0.5).set_trans(Tween.TRANS_BOUNCE)
	
	await get_tree().create_timer(1.5).timeout
	dice_sprite.stop()
	check_result(bet_type)

func check_result(bet_type):
	var result = randi() % 6 + 1
	dice_sprite.frame = result - 1
	
	var win = (bet_type == ">3" and result > 3) or (bet_type == "<=3" and result <= 3)
	
	if win:
		$Panel/Label.text = "Выпало %d!\nТы выиграл %s!" % [result, item_to_win]
		await get_tree().create_timer(1.5).timeout
		#Global.give_item(item_to_win)
		queue_free()  # Закрытие при победе
	else:
		$Panel/Label.text = "Выпало %d...\nПопробуй ещё!" % result
		is_rolling = false
