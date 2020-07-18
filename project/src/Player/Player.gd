class_name Player
extends KinematicBody2D

onready var _collisionshape : CollisionShape2D = $CollisionShape2D
onready var actiontimer : Timer = $Actiontimer

export var _jumptime := 0.2
export var _ducktime := 0.4
export var _jumpspeed := 10

var _jumping := false
var _ducking := false
var _up := false


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down") and not _ducking and not _jumping:
		_ducking = true
		actiontimer.start(_ducktime)
	elif Input.is_action_just_pressed("ui_up") and not _ducking and not _jumping:
		_jumping = true
		_up = true
		actiontimer.start(_jumptime)
	var _velocity := Vector2(0,0)
	if _up:
		_velocity.y -= 1
	elif _jumping and not _up:
		_velocity.y += 1
	_velocity *= _jumpspeed*delta
	var _error = move_and_collide(_velocity)


func _on_Actiontimer_timeout():
	if _jumping and _up:
		_up = false
		actiontimer.start(_jumptime)
	elif _jumping and not _up:
		_jumping = false
	if _ducking:
		_ducking = false
