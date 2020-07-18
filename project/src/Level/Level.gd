extends Node2D

onready var _obstacletimer : Timer = $Timer

export var slidespeed := 10.0

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
	var _type = 1#randi()%2
	var obstacle
	var Obstacle
	if _type == 1:
		obstacle = load("res://src/Obstacles/GroundThing.tscn")
		Obstacle = obstacle.instance()
		Obstacle.position = Vector2(screensize.x, 400)
	add_child(Obstacle)
	slidespeed += 1
