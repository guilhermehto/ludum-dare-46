extends Spatial

signal unlit

onready var current_wood_timer : Timer = $CurrentWoodTimer
onready var woods : Node = $Woods
onready var effective_shape = $Area/CollisionShape

export var max_woods : int = 10
export var minimun_effectiviness : float = 0.25
export var heating_up_rate : float = 2.0

var warm_bodies = []

func _ready() -> void:
	current_wood_timer.wait_time = woods.get_children()[0].burning_time_s
	current_wood_timer.start()
	woods.remove_child(woods.get_children()[0])

func _process(delta: float) -> void:
	for body in warm_bodies:
		var distance_from_bonfire = global_transform.origin.distance_to(body.get_parent().global_transform.origin)
		var distance_modifier = distance_from_bonfire / effective_shape.shape.radius
		body.temperature += heating_up_rate * delta * max(distance_modifier, minimun_effectiviness)

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

func _on_Area_body_entered(body: Node) -> void:
	if not body.warm_body:
		return
	warm_bodies.append(body.warm_body)

func _on_Area_body_exited(body: Node) -> void:
	if not body.warm_body:
		return
	warm_bodies.remove(warm_bodies.bsearch(body.warm_body))
