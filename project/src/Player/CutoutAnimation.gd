class_name Cutout
extends Node2D

signal hit_something(area)
signal duck_over

onready var _ducklength = $AnimationPlayer.get_animation("Duck").length


# Play the duck animation
func duck() -> void:
	$AnimationTree["parameters/DuckOneShot/active"] = true
	yield(get_tree().create_timer(_ducklength), "timeout")
	emit_signal("duck_over")


func stop_all_animations():
	$AnimationTree.active = false


func _on_Area2D_area_entered(area):
	emit_signal("hit_something", area)

