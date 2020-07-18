extends Node2D

onready var _obstacletimer : Timer = $Timer

export var slidespeed := 15.0

var screensize := Vector2(0,0)

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(_delta):
	var _moving_nodes = get_tree().get_nodes_in_group("Moving")
	for object in _moving_nodes:
		if object.position.x > 0:
			object.position.x -= slidespeed
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
		Obstacle.position = Vector2(screensize.x, 200)
		add_child(Obstacle)
