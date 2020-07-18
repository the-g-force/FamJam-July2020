extends Area2D

onready var _sprite = $AnimatedSprite


func _on_GroundThing_body_entered(body):
	if body is Player:
		print("hit")
