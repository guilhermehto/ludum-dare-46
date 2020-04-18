extends VBoxContainer

onready var wood_label : Label = $Wood/Label
onready var capacity_label : Label = $Capacity/Label

func _ready() -> void:
	wood_label.text = "Wood: 0"
	capacity_label.text = "Weight: 0/20"

func update_text(info) -> void:
	if info.item is Wood:
		wood_label.text = "Wood: %s" % info.carrying
	capacity_label.text = "Weight: %s/%s" % [info.carrying_weight, info.weight_limit]
