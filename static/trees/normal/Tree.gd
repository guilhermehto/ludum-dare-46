extends Spatial
class_name WoodTree

onready var timer : Timer = $Timer
onready var mesh_instace : MeshInstance = $MeshInstance

export var time_to_regrow_stage : float = 120.0
export var stage_meshes = []
export var drops = []
export var initial_hp : float = 50.0
export var max_drops : int = 4

var growth_stage = 3
var current_hp = initial_hp

func _ready() -> void:
	randomize()
	timer.wait_time = time_to_regrow_stage

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_fall()

func _fall() -> void:
	# drop stuff
	growth_stage = 1
	timer.start()
	mesh_instace.mesh = stage_meshes[0]
	for i in rand_range(max_drops / 2, max_drops):
		var drop = drops[randi() % drops.size()].instance()
		add_child(drop)
		drop.set_as_toplevel(true)
		var random_direction = Vector3(randi() % 3, 0, randi() % 3).normalized()
		drop.global_transform.origin = global_transform.origin + random_direction * Vector3(randi() % 5, 0, randi() % 5)
	
func _on_Timer_timeout() -> void:
	growth_stage += 1
	mesh_instace.mesh = stage_meshes[growth_stage - 1]
	
	if growth_stage < 3:
		timer.start()
	else:
		current_hp = initial_hp

func hit(damage: float) -> void:
	# todo: animations and shit
	if growth_stage != 3:
		return
	current_hp -= damage
	if current_hp <= 0:
		_fall()
		timer.start()
