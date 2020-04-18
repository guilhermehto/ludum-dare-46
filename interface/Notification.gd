extends Label

onready var timer : Timer = $Timer

export var notification_time : float = 5.0

func _ready() -> void:
	timer.wait_time = notification_time
	GlobalSignals.connect("notified", self, "_on_notified")

func _on_notified(notification_text: String) -> void:
	text = notification_text
	timer.start()
	show()

func _on_Timer_timeout() -> void:
	hide()
