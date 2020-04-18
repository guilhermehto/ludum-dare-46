extends WorldEnvironment

onready var timer : Timer = $Timer

export var day_length : float = 60 * 3 # 3 minutes

var passed_days : int = 0

func _ready() -> void:
	timer.wait_time = day_length
	timer.start()

func _process(delta: float) -> void:
	var modifier = -1 if timer.time_left > day_length / 2 else 1
	var rate = 1 / (day_length / 2.0) * delta * modifier
	var current_color = environment.ambient_light_color
	environment.ambient_light_energy += rate * 0.75
	environment.ambient_light_color = Color(current_color.r + rate,
		current_color.g + rate,
		current_color.b + rate)

func _on_Timer_timeout() -> void:
	passed_days += 1
	GlobalSignals.emit_day_passed(passed_days)
