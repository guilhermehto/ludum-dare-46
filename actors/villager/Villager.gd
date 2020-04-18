extends KinematicBody

signal died

onready var warm_body = $WarmBody

export var max_hp : int = 25

var hp : int = max_hp

func damage(value: int) -> void:
	hp = max(0, hp - value)
	if hp == 0:
		emit_signal("died")
		queue_free()

func _on_WarmBody_cold_damaged(damage) -> void:
	damage(damage)
