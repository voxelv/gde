extends HBoxContainer

signal produced

onready var progress_list = find_node("progress_list")

export(float) var teammate_multiplier = 1.2
export(float) var max_work = 150.0

var work = 0.0
var worker_cnt = 1

func _ready():
	for i in range(gde_const.WORKERS_PER_GROUP):
		var new_progress = ProgressBar.new()
		progress_list.add_child(new_progress)
		new_progress.allow_greater = true
		new_progress.percent_visible = false
		new_progress.size_flags_vertical = SIZE_EXPAND_FILL

func _on_production_tick():
	work += pow(teammate_multiplier, worker_cnt)
	if work > max_work:
		work = 1
		emit_signal("produced", worker_cnt)
	
	var work_progress = float(work) / float(max_work)
	for i in range(worker_cnt):
		progress_list.get_child(i).ratio = work_progress
