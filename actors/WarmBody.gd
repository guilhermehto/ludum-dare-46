extends Node
class_name WarmBody

signal died

onready var timer : Timer = $Timer

export var decay_rate : float = 0.3
export var max_body_temperature : float = 38
export var minimun_body_temperature : float = 30
export var temperature : float = 35 setget set_temperature

var cold_resistance : float = 1.0
var dead = false

func _process(delta: float) -> void:
	if dead:
		return
	self.temperature -= delta * cold_resistance * decay_rate
	if temperature <= minimun_body_temperature:
		emit_signal("died")
		dead = true
		

func set_temperature(value: float) -> void:
	temperature = min(value, max_body_temperature)
