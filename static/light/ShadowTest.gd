extends Spatial

onready var lights = $Lights
onready var timer = $Timer

var initial_ranges = []

var intensity : float setget set_intensity

var starting_enegery = []

func _ready() -> void:
	for light in lights.get_children():
		starting_enegery.append(light.light_energy)
	
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

func set_intensity(value: float ) -> void:
	var children = lights.get_children()
	for index in lights.get_child_count():
		children[index].light_energy = starting_enegery[index] * value
