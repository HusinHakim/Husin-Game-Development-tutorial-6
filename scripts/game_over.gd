extends ColorRect

func _on_try_again_pressed() -> void:
	Global.lives = 3
	SceneTransition.change_scene("res://scenes/Level 1.tscn")

func _on_back_pressed() -> void:
	Global.lives = 3
	SceneTransition.change_scene("res://scenes/MainMenu.tscn")
