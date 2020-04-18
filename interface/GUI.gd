extends Control

onready var inventory = $Inventory

func _ready() -> void:
	GlobalSignals.connect("inventory_item_added", self, "_on_inventory_item_added")

func _on_inventory_item_added(info):
	inventory.update_text(info)
