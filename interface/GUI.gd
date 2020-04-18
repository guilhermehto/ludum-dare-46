extends Control

onready var inventory = $Inventory

func _ready() -> void:
	GlobalSignals.connect("inventory_updated", self, "_on_inventory_updated")

func _on_inventory_updated(info):
	inventory.update_text(info)
