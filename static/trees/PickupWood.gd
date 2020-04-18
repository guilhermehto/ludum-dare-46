extends Spatial

onready var info = $Info

export var move_speed : float = 10.0
export var pickup_distance : float = 1.0

var target : Spatial

func _process(delta: float) -> void:
	if not target:
		return
	if target.inventory.capacity < info.weight:
		target = null
		return
	var distance_to_target = global_transform.origin.distance_to(target.global_transform.origin)
	if distance_to_target <= pickup_distance:
		remove_child(info)
		target.inventory.add_item(info)
		queue_free()
	var direction := (target.global_transform.origin - global_transform.origin).normalized()
	global_transform.origin += direction * move_speed * delta

func _on_Area_body_entered(body: Node) -> void:
	if body is Player and body.inventory.capacity >= info.weight:
		target = body

func _on_Area_body_exited(body: Node) -> void:
	if body is Player:
		target = null
