extends Spatial

func _ready() -> void:
	randomize()
	var new_scale = rand_range(0.75, 1.25)
	scale = Vector3(new_scale, new_scale, new_scale)
	rotate_y(randf() * 3.65)
