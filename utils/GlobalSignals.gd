extends Node

signal inventory_item_added(info)

func emit_inventory_item_added(info):
	emit_signal("inventory_item_added", info)
