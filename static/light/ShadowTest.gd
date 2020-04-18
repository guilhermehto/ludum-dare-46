extends Spatial

onready var lights = $Lights
onready var timer = $Timer

var initial_ranges = []

func _ready() -> void:
	randomize()
	timer.wait_time = randf() * 0.75
	timer.start()
	for child in lights.get_children():
		initial_ranges.append(child.omni_range)

func _on_Timer_timeout() -> void:
	var children = lights.get_children()
#	var index = randi() % children.size()
	for index in children.size():
		var max_change = initial_ranges[index] * 0.05
		children[index].omni_range = initial_ranges[index] + rand_range(-max_change, max_change)
	timer.wait_time = randf() * 0.75
	timer.start()
