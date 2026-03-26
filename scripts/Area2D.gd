extends Area2D

@export var sceneName: String = "Level 1"

func _on_Area_Trigger_body_entered(body):
	var current_scene = get_tree().get_current_scene().get_name()
	if body.get_name() == "Player":
		if current_scene == sceneName:
			Global.lives -= 1
		if Global.lives == 0:
			SceneTransition.change_scene("res://scenes/Game Over.tscn")
		else:
			SceneTransition.change_scene("res://scenes/" + sceneName + ".tscn")
