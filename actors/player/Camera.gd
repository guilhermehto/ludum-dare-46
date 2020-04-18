extends Camera

var z_difference : float

func _ready() -> void:
	set_as_toplevel(true)
	z_difference = translation.z

func _process(delta: float) -> void:
	var target_pos = get_parent().global_transform.origin
	target_pos.y = global_transform.origin.y
	target_pos.z = target_pos.z + z_difference
	global_transform.origin = target_pos
