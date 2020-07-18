extends Node2D

onready var _obstacletimer : Timer = $Timer
onready var _scorelabel : Label = $ScoreLabel
onready var _popup_score_label : Label = $PopupDialog/VBoxContainer/Label

export var slidespeed := 800
export var head_y := 280
export var feet_y := 500

var screensize := Vector2(0,0)
var score := 0

func _ready():
	screensize = get_viewport_rect().size


func _physics_process(delta):
	# Update score label
	_scorelabel.text = str(score)
	
	# Scroll the background
	$ParallaxBackground.scroll_offset.x -= slidespeed/2.0 * delta
	
	# Move all the obstacles
	var _moving_nodes = get_tree().get_nodes_in_group("Moving")
	for object in _moving_nodes:
		if object.position.x > 0:
			object.position.x -= slidespeed * delta
		else:
			object.queue_free()


func _on_Timer_timeout():
	score += 1
	var _type = randi()%2
	if _type == 1:
		var obstacle
		obstacle = load("res://src/Obstacles/GroundThing.tscn")
		var Obstacle
		Obstacle = obstacle.instance()
		Obstacle.position = Vector2(screensize.x, feet_y)
		add_child(Obstacle)
	elif _type == 0:
		var obstacle
		obstacle = load("res://src/Obstacles/FlyingThing.tscn")
		var Obstacle
		Obstacle = obstacle.instance()
		Obstacle.position = Vector2(screensize.x, head_y)
		add_child(Obstacle)


func _on_Player_end_game():
	# Stop the game
	slidespeed = 0
	_obstacletimer.stop()
	
	# Update the popup text
	_popup_score_label.text = _popup_score_label.text.replace('X', str(score))
	
	# Show the popup
	$PopupDialog.popup_centered()
	
	
func _on_BackToMenuButton_pressed():
	var _ignored_return_value = get_tree().change_scene("res://src/MenuScene.tscn")


func _on_JumpButton_pressed():
	Input.action_press("jump")


func _on_DuckButton_pressed():
	Input.action_press("duck")


func _on_PlayAgainButton_pressed():
	var _ignored_return_value = get_tree().change_scene("res://src/Level/Level.tscn")
