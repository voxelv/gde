extends Node

signal production_tick

const max_int = 1152921504606846975

export var hired_worker_cost_coeff = [0.7, 0.15]

var hire_group = preload("res://hired_worker_group.tscn")

onready var ec_label_bytes = [
	find_node("ec_label_byte78"),
	find_node("ec_label_byte56"),
	find_node("ec_label_byte34"),
	find_node("ec_label_byte12"),
	]
onready var hire_button = find_node("hire_button")
onready var hired_worker_list = find_node("hired_worker_list")
onready var production_timer:Timer = find_node("production_timer") as Timer

var ui_dirty = true
var energy_credits = 0
var hired_worker_cost = 0x10
var hired_worker_cnt = 0

func _ready():
	calc_worker_cost()
	production_timer.connect("timeout", self, "_on_production_timer_timeout")

func _process(delta):
	if ui_dirty:
		ui_dirty = false
		update_ui()

func update_ui():
	# update energy credits labels
	var ec_string = "%016X" % energy_credits
	for i in range(4):
		ec_label_bytes[i].text = ec_string.substr(i * 4, 4)
	
	# update hire button label
	hire_button.text = "(%04X" % hired_worker_cnt + (") Hire %04X" % hired_worker_cost)

func _on_mine_button_pressed():
	energy_credits += 1
	ui_dirty = true

func calc_worker_cost():
	var w = hired_worker_cnt
	hired_worker_cost = floor(hired_worker_cost_coeff[0] * w * w + hired_worker_cost_coeff[1] * w + 0x10)

func _on_hire_button_pressed():
	if energy_credits >= hired_worker_cost:
		energy_credits -= hired_worker_cost
		ui_dirty = true
		hire_worker()
		calc_worker_cost()

func hire_worker():
	hired_worker_cnt += 1
	if (hired_worker_cnt % gde_const.WORKERS_PER_GROUP) == 1:
		var new_worker_group = hire_group.instance()
		hired_worker_list.add_child(new_worker_group)
		production_timer.connect("timeout", new_worker_group, "_on_production_tick")
		new_worker_group.connect("produced", self, "_on_hired_worker_produced")
	else:
		var worker_group = hired_worker_list.get_child((hired_worker_cnt - 1) / gde_const.WORKERS_PER_GROUP)
		worker_group.worker_cnt += 1

func _on_hired_worker_produced(amt):
	energy_credits += amt
	ui_dirty = true

func _on_production_timer_timeout():
	emit_signal("production_tick")
	production_timer.start()
