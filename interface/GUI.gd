extends Control

onready var inventory = $Inventory
onready var counters = $Counters
onready var stats = $Stats

var player_ref : Player = null

func initialize(player: Player) -> void:
	player_ref = player
	stats.initialize(player_ref)

func _ready() -> void:
	GlobalSignals.connect("inventory_updated", self, "_on_inventory_updated")
	GlobalSignals.connect("day_passed", self, "_on_day_passed")

func _on_inventory_updated(info) -> void:
	inventory.update_text(info)

func _on_day_passed(days) -> void:
	counters.update_days(days)
