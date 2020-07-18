class_name Player
extends Node2D

signal end_game

const DEATH_SOUNDS = [
	preload("res://assets/sfx/DEEAAATHHHHH.wav"),
	preload("res://assets/sfx/DEEAAATHHHHH2.wav"),
	preload("res://assets/sfx/DEEAAATHHHHH3.wav")
]

const JUMP_SOUNDS = [
	preload("res://assets/sfx/JUMP.wav"),
	preload("res://assets/sfx/JUMP2.wav"),
	preload("res://assets/sfx/JUMP3.wav"),
]

const DUCK_SOUNDS = [
	preload("res://assets/sfx/DUCK.wav"),
	preload("res://assets/sfx/DUCK2.wav"),
	preload("res://assets/sfx/DUCK3.wav")
]

onready var _jump : AnimationPlayer = $AnimationPlayer
onready var _cutout : Cutout = $CutoutAnimation

var _jumping := false
var _ducking := false
var _playing := true

func _physics_process(_delta):
	if _playing:
		if Input.is_action_just_pressed("duck") and not _ducking and not _jumping:
			_ducking = true
			_cutout.duck()
			_play_random_sound(DUCK_SOUNDS)
		elif Input.is_action_just_pressed("jump") and not _ducking and not _jumping:
			_jumping = true
			_jump.play("Jump")
			_play_random_sound(JUMP_SOUNDS)


func _on_CutoutAnimation_hit_something(area):
	if area is Obstacle and _playing:
		_playing = false
		$CutoutAnimation.stop_all_animations()
		_play_random_sound(DEATH_SOUNDS)
		emit_signal("end_game")


func _on_CutoutAnimation_duck_over():
	_ducking = false


func _on_AnimationPlayer_animation_finished(_anim_name):
	_jumping = false


func _play_random_sound(array):
	var stream : AudioStream = array[randi() % array.size()]
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.playing = true
