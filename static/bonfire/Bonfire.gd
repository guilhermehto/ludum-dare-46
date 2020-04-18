extends Spatial

signal unlit

onready var current_wood_timer : Timer = $CurrentWoodTimer
onready var woods : Node = $Woods

export var max_woods : int = 10

func _ready() -> void:
	current_wood_timer.wait_time = woods.get_children()[0].burning_time_s
	current_wood_timer.start()
	woods.remove_child(woods.get_children()[0])

func _on_CurrentWoodTimer_timeout() -> void:
	if woods.get_child_count() == 0:
		emit_signal("unlit")
		return
	
	current_wood_timer.wait_time = woods.get_children()[0].burning_time_s
	current_wood_timer.start()
	woods.remove_child(woods.get_children()[0])

func add_wood(wood) -> bool:
	if woods.get_child_count() == max_woods:
		return false

	woods.add_child(wood)
	return true
