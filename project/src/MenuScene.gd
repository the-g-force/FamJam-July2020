extends Control

onready var _Level = preload("res://src/Level/Level.tscn")

func _on_Button_pressed():
	var _ignoredResult = get_tree().change_scene_to(_Level)
