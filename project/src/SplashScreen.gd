extends Node2D

var _MainMenu : PackedScene = preload("res://src/MenuScene.tscn")

func _input(event):
	if event is InputEventMouseButton:
		var _ignored_result = get_tree().change_scene_to(_MainMenu)
