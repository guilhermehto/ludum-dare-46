extends Node

signal inventory_updated(info)
signal notified(notification_text)

func emit_inventory_updated(info) -> void:
	emit_signal("inventory_updated", info)

func emit_notified(text) -> void:
	emit_signal("notified", text)
