extends Control

onready var _MUSIC_BUS : int = AudioServer.get_bus_index("Music")
onready var _Level = preload("res://src/Level/Level.tscn")

func _on_Button_pressed():
	var _ignoredResult = get_tree().change_scene_to(_Level)


func _on_MusicMuteToggle_toggled(button_pressed):
	AudioServer.set_bus_mute(_MUSIC_BUS, not button_pressed)
