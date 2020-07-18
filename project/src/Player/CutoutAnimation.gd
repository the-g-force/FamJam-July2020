extends Node2D

# Play the duck animation
func duck() -> void:
	$AnimationTree["parameters/DuckOneShot/active"] = true
