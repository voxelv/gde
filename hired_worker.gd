extends HBoxContainer

signal produced

onready var progress = find_node("progress")
onready var production_timer = find_node("production_timer")

func _ready():
	pass


func _on_production_timer_timeout():
	progress.value += 1
	if progress.value == 100:
		progress.value = 0
		emit_signal("produced")
		production_timer.start()
