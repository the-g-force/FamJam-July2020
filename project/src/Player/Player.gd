class_name Player
extends Node2D

onready var _actiontimer : Timer = $Actiontimer
onready var _cutout : Cutout = $CutoutAnimation

export var _jumptime := 0.2
export var _ducktime := 0.4
export var _jumpspeed := 10

var _jumping := false
var _ducking := false
var _up := false
var _playing := true

signal end_game

func _physics_process(delta):
	if _playing:
		if Input.is_action_just_pressed("duck") and not _ducking and not _jumping:
			_ducking = true
			_cutout.duck()
		elif Input.is_action_just_pressed("jump") and not _ducking and not _jumping:
			_jumping = true
			_up = true
			_actiontimer.start(_jumptime)
		var _velocity := Vector2(0,0)
		if _up:
			_velocity.y -= 1
		elif _jumping and not _up:
			_velocity.y += 1
		_velocity *= _jumpspeed*delta
		position += _velocity


func _on_Actiontimer_timeout():
	if _playing:
		if _jumping and _up:
			_up = false
			_actiontimer.start(_jumptime)
		elif _jumping and not _up:
			_jumping = false
			position = Vector2(100,500)


func _on_CutoutAnimation_hit_something(area):
	if area is Obstacle:
		_playing = false
		$CutoutAnimation.stop_all_animations()
		emit_signal("end_game")


func _on_CutoutAnimation_duck_over():
	_ducking = false
