extends Spatial

onready var crafting_list : VBoxContainer = $UI/VBoxContainer/CraftingList
onready var ui : Control = $UI

var player_ref = false

var craftables: Dictionary = {
	"axe": {
		"wood": 2,
		"stone": 0,
		"can_craft": false,
		"item_path": "res://items/Axe.tscn"
	}
}

func open_ui() -> void:
	_update_ui()
	ui.visible = true

func close_ui() -> void:
	ui.visible = false

func _update_ui() -> void:
	_update_craftables()
	for child in crafting_list.get_children():
		var key = child.name.to_lower()
		child.visible = craftables[key].can_craft

func _update_craftables() -> void:
	var wood_count = player_ref.inventory.woods.get_child_count()
	var stone_count = player_ref.inventory.stones.get_child_count()
	for key in craftables.keys():
		var craftable = craftables[key]
		craftables[key].can_craft = wood_count >= craftable.wood \
			and stone_count >= craftable.stone

func _craft_axe() -> void:
	if player_ref.hands.get_child_count() > 0:
		GlobalSignals.emit_notified("Already carrying an axe")
		return
	for i in craftables.axe.wood:
		player_ref.inventory.remove_wood().queue_free()
	
	var axe = load(craftables.axe.item_path).instance()
	player_ref.hands.add_child(axe)
	axe.translation = Vector3.ZERO
	_update_ui()
	GlobalSignals.emit_notified("Axe crafted")
