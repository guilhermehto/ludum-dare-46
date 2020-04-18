extends Node
class_name WarmBody

signal cold_damaged(damage)

onready var timer : Timer = $Timer

export var decay_rate : float
export var max_body_temperature : float
export var minimun_body_temperature : float
export var temperature : float setget set_temperature
export var cold_damage : int = 5
export var cold_damage_interval : int = 2

var cold_resistance : float = 1.0

func _ready() -> void:
	timer.wait_time = cold_damage_interval

func _process(delta: float) -> void:
	self.temperature -= delta * cold_resistance * decay_rate
	if temperature <= minimun_body_temperature and timer.is_stopped():
		emit_signal("cold_damaged", cold_damage)
		timer.start()

func set_temperature(value: float) -> void:
	temperature = min(value, max_body_temperature)

func _on_Timer_timeout() -> void:
	if temperature <= minimun_body_temperature:
		emit_signal("cold_damaged", cold_damage)
		timer.start()
