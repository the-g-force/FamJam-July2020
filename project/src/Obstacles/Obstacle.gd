class_name Obstacle
extends Area2D

onready var _sprite : AnimatedSprite = $AnimatedSprite

func _ready():
	var _type := randi()%4
	_sprite.animation = str(_type)
