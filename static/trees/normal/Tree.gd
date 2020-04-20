extends Spatial
class_name WoodTree

onready var timer : Timer = $Timer
onready var meshes : Spatial = $Meshes
onready var tween : Tween = $Tween
onready var particle_position : Position3D = $ParticlePosition

export var time_to_regrow_stage : float = 120.0
export var stage_meshes = []
export var drops = []
export var initial_hp : float = 50.0
export var max_drops : int = 4
export var hit_particles : PackedScene

var growth_stage = 3
var current_hp = initial_hp

func _ready() -> void:
	randomize()
	timer.wait_time = time_to_regrow_stage
	scale *= rand_range(0.75, 1.25)
	rotate_y(randf() * 3.65)

func _show_mesh(index: int) -> void:
	for mesh in meshes.get_children():
		mesh.hide()
	meshes.get_children()[index].show()

func _fall() -> void:
	# drop stuff
	growth_stage = 1
	timer.start()
	_show_mesh(0)
	for i in rand_range(max_drops / 2, max_drops):
		var drop = drops[randi() % drops.size()].instance()
		add_child(drop)
		drop.set_as_toplevel(true)
		var random_direction = Vector3(randi() % 3, 0.5, randi() % 3).normalized()
		drop.global_transform.origin = global_transform.origin + random_direction * Vector3(randi() % 5, 0, randi() % 5)
	
func _on_Timer_timeout() -> void:
	growth_stage += 1
	_show_mesh(growth_stage - 1)
	
	if growth_stage < 3:
		timer.start()
	else:
		current_hp = initial_hp

func hit(damage: float) -> void:
	# todo: animations and shit
	if growth_stage != 3:
		return
	current_hp -= damage
	var initial_scale = scale
	var duration = 0.1
	tween.interpolate_property(self, "scale", scale, scale + Vector3(.1, .1, .1), duration, Tween.TRANS_ELASTIC, Tween.EASE_OUT, .2)
	tween.interpolate_property(self, "scale", scale, initial_scale, duration, Tween.TRANS_QUINT, Tween.EASE_OUT, .2 + duration)
	tween.start()
	var particles = hit_particles.instance()
	add_child(particles)
	particles.translation = particle_position.translation
	particles.emitting = true
	if current_hp <= 0:
		_fall()
		timer.start()
