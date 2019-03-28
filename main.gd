extends Node

const max_int = 1152921504606846975
const hired_worker_cost = 0xF

var hire = preload("res://hired_worker.tscn")

onready var ec_label_bytes = [
	find_node("ec_label_byte78"),
	find_node("ec_label_byte56"),
	find_node("ec_label_byte34"),
	find_node("ec_label_byte12"),
	]
onready var hired_worker_list = find_node("hired_worker_list")

var ui_dirty = true
var energy_credits = 0

func _ready():
	update_energy_credits_labels()

func _process(delta):
	if ui_dirty:
		ui_dirty = false
		update_ui()

func update_ui():
	update_energy_credits_labels()

func update_energy_credits_labels():
	var ec_string = "%016X" % energy_credits
	for i in range(4):
		ec_label_bytes[i].text = ec_string.substr(i * 4, 4)

func _on_mine_button_pressed():
	energy_credits += 1
	ui_dirty = true

func _on_hire_button_pressed():
	if energy_credits >= hired_worker_cost:
		energy_credits -= hired_worker_cost
		ui_dirty = true
		var new_hired_worker = hire.instance()
		hired_worker_list.add_child(new_hired_worker)
		new_hired_worker.connect("produced", self, "_on_hired_worker_produced")

func _on_hired_worker_produced():
	energy_credits += 1
	ui_dirty = true
