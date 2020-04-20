extends Spatial

signal hit

onready var cooldown : Timer = $Cooldown
onready var hit_timer : Timer = $HitTime
onready var hitbox : Area = $Area/CollisionShape

export var damage : int = 15
export var hits : int = 10

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_action") and cooldown.is_stopped():
		cooldown.start()
		hit_timer.start()
		hitbox.disabled = false
		emit_signal("hit")
		

func brake_axe() -> void:
	GlobalSignals.emit_notified("Your axe broke")
	queue_free()

func _on_Area_body_entered(body: Node) -> void:
	if not hit_timer.is_stopped():
		if body is WoodTree:
			body.hit(damage)
			hitbox.disabled = true
			hits -= 1
			if hits == 0:
				brake_axe()

func _on_HitTime_timeout() -> void:
	hitbox.disabled = true
