extends ColorRect

func _on_play_again_pressed() -> void:
	Global.lives = 3
	SceneTransition.change_scene("res://scenes/Level 1.tscn")

func _on_main_menu_pressed() -> void:
	Global.lives = 3
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
