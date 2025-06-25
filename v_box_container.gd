extends VBoxContainer

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://intro.tscn") 

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_settings_button_pressed():
	var settings_menu = load("res://settings_menu.tscn").instantiate()
	get_tree().root.add_child(settings_menu)  # Добавляем поверх всего
