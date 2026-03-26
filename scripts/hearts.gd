extends MarginContainer

var full_heart = preload("res://assets/kenney_platformerpack/PNG/HUD/hudHeart_full.png")
var empty_heart = preload("res://assets/kenney_platformerpack/PNG/HUD/hudHeart_empty.png")

@onready var heart1: TextureRect = $HBoxContainer/Heart1
@onready var heart2: TextureRect = $HBoxContainer/Heart2
@onready var heart3: TextureRect = $HBoxContainer/Heart3

func _process(_delta: float) -> void:
	heart1.texture = full_heart if Global.lives >= 1 else empty_heart
	heart2.texture = full_heart if Global.lives >= 2 else empty_heart
	heart3.texture = full_heart if Global.lives >= 3 else empty_heart
