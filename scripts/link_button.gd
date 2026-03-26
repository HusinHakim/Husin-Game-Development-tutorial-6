extends LinkButton

@export var scene_to_load: String

func _on_New_Game_pressed():
	SceneTransition.change_scene("res://scenes/" + scene_to_load + ".tscn")

func _on_pressed():
	SceneTransition.change_scene("res://scenes/" + scene_to_load + ".tscn")
