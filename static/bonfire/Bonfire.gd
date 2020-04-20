extends Spatial

signal unlit

onready var current_wood_timer : Timer = $CurrentWoodTimer
onready var woods : Node = $Woods
onready var effective_shape = $Area/CollisionShape
onready var particles = $Particles
onready var lights = $Lights

export var infinite : bool = false
export var max_woods : int = 10
export var minimun_effectiviness : float = 0.25
export var heating_up_rate : float = 2.0

var burn_rate : float = 0
var player : Player = null

func _ready() -> void:
	current_wood_timer.wait_time = woods.get_children()[0].burning_time_s
	current_wood_timer.start()
	woods.remove_child(woods.get_children()[0])
	lights.intensity = woods.get_child_count() / float(max_woods)

func _process(delta: float) -> void:
	burn_rate += delta * .005
	if not particles.emitting or not player:
		return
	var distance_from_bonfire = global_transform.origin.distance_to(player.global_transform.origin)
	var distance_modifier = 1 - distance_from_bonfire / effective_shape.shape.radius
	player.warm_body.temperature += heating_up_rate * delta * max(distance_modifier, minimun_effectiviness)

func _on_CurrentWoodTimer_timeout() -> void:
	if infinite:
		return
	if woods.get_child_count() == 0:
		particles.emitting = false
		lights.visible = false
		emit_signal("unlit")
		GlobalSignals.emit_game_ended("Bonfire extinguished")
		return
	var calculated_burn_time = woods.get_children()[0].burning_time_s - woods.get_children()[0].burning_time_s * burn_rate
	calculated_burn_time = max(calculated_burn_time, 3.5)
	current_wood_timer.wait_time = calculated_burn_time
	print(current_wood_timer.wait_time)
	current_wood_timer.start()
	woods.remove_child(woods.get_children()[0])
	if woods.get_child_count() > 0:
		lights.intensity = woods.get_child_count() / float(max_woods)

func add_wood(wood) -> bool:
	if woods.get_child_count() == max_woods:
		return false
	woods.add_child(wood)
	
	if not particles.emitting:
		particles.emitting = true
		lights.visible = true
		var calculated_burn_time = woods.get_children()[0].burning_time_s - woods.get_children()[0].burning_time_s * burn_rate
		calculated_burn_time = max(calculated_burn_time, 3.5)
		current_wood_timer.wait_time = calculated_burn_time
		current_wood_timer.start()
	lights.intensity = woods.get_child_count() / float(max_woods)
	return true

func _on_Area_body_entered(body: Node) -> void:
	if not body is Player:
		return
	player = body

func _on_Area_body_exited(body: Node) -> void:
	if not body is Player:
		return
	player = null
