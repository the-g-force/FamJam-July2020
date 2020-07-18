extends Node2D

onready var _obstacletimer : Timer = $Timer

export var slidespeed := 800

var screensize := Vector2(0,0)

func _ready():
	screensize = get_viewport_rect().size


func _physics_process(delta):
	var _moving_nodes = get_tree().get_nodes_in_group("Moving")
	for object in _moving_nodes:
		if object.position.x > 0:
			object.position.x -= slidespeed * delta
		else:
			object.queue_free()


func _on_Timer_timeout():
	randomize()
	var _type = randi()%2
	if _type == 1:
		var obstacle
		obstacle = load("res://src/Obstacles/GroundThing.tscn")
		var Obstacle
		Obstacle = obstacle.instance()
		Obstacle.position = Vector2(screensize.x, 400)
		add_child(Obstacle)
	elif _type == 0:
		var obstacle
		obstacle = load("res://src/Obstacles/FlyingThing.tscn")
		var Obstacle
		Obstacle = obstacle.instance()
		Obstacle.position = Vector2(screensize.x, 180)
		add_child(Obstacle)


func _on_Player_end_game():
	# Stop the game
	slidespeed = 0
	_obstacletimer.stop()
	
	# Show the popup
	$PopupDialog.popup_centered()
	
	
func _on_BackToMenuButton_pressed():
	get_tree().change_scene("res://src/MenuScene.tscn")
