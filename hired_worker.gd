extends HBoxContainer

signal produced

onready var progress_list = find_node("progress_list")

export(int) var max_work = 100

var work = 0
var worker_cnt = 1

func _ready():
	pass

func _on_production_tick():
	work += 1
	if work > max_work:
		work = 1
		emit_signal("produced", worker_cnt)
	
	var work_progress = float(work) / float(max_work)
	for i in range(worker_cnt):
		progress_list.get_child(i).ratio = work_progress
