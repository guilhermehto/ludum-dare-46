extends AudioStreamPlayer

onready var timer : Timer = $Timer

export var step_interval : float = 0.1

var is_playing : bool = false

func _ready():
	timer.wait_time = step_interval

func start_walk():
	is_playing = true
	play()
	timer.start()

func stop_walk():
	is_playing = false


func _on_Timer_timeout():
	if is_playing:
		play()
		timer.start()
