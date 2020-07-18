extends Control

onready var _MUSIC_BUS : int = AudioServer.get_bus_index("Music")
onready var _Level = preload("res://src/Level/Level.tscn")
onready var _musicmute_toggle = $Controls/MusicMuteToggle
onready var _fullscreen_toggle = $Controls/FullScreenToggle

func _ready():
	_musicmute_toggle.pressed = false if AudioServer.is_bus_mute(_MUSIC_BUS) else true
	_fullscreen_toggle = true if OS.window_fullscreen else false

func _on_Button_pressed():
	var _ignoredResult = get_tree().change_scene_to(_Level)


func _on_MusicMuteToggle_toggled(button_pressed):
	AudioServer.set_bus_mute(_MUSIC_BUS, not button_pressed)


func _on_FullScreenToggle_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
