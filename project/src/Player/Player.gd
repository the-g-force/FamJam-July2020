class_name Player
extends Node2D

onready var _jump : AnimationPlayer = $AnimationPlayer
onready var _cutout : Cutout = $CutoutAnimation

var _jumping := false
var _ducking := false
var _playing := true

signal end_game

func _physics_process(delta):
	if _playing:
		if Input.is_action_just_pressed("duck") and not _ducking and not _jumping:
			_ducking = true
			_cutout.duck()
		elif Input.is_action_just_pressed("jump") and not _ducking and not _jumping:
			_jumping = true
			_jump.play("Jump")


func _on_CutoutAnimation_hit_something(area):
	if area is Obstacle:
		_playing = false
		$CutoutAnimation.stop_all_animations()
		emit_signal("end_game")


func _on_CutoutAnimation_duck_over():
	_ducking = false


func _on_AnimationPlayer_animation_finished(anim_name):
	_jumping = false
