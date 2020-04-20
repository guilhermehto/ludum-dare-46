extends Node

signal inventory_updated(info)
signal notified(notification_text)
signal day_passed(days)
signal game_ended(reason)

func emit_inventory_updated(info) -> void:
	emit_signal("inventory_updated", info)

func emit_notified(text) -> void:
	emit_signal("notified", text)

func emit_day_passed(days) -> void:
	emit_signal("day_passed", days)

func emit_game_ended(reason) -> void:
	emit_signal("game_ended", reason)
