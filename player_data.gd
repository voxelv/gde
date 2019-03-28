extends Node

var energy_credits = 0
var milestone = []

func _init():
	for i in range(gde_const.MILESTONE.COUNT):
		milestone.append(false)
	set_process(true)

func _process(delta):
	if energy_credits > 0:
		milestone[gde_const.MILESTONE.ABOVE_0] = true
	if energy_credits >= 0x10:
		milestone[gde_const.MILESTONE.REACHED_10] = true
	if energy_credits > 0xFFFF:
		milestone[gde_const.MILESTONE.ABOVE_FFFF] = true
	if energy_credits > 0xFFFFFFFF:
		milestone[gde_const.MILESTONE.ABOVE_FFFFFFFF] = true
	if energy_credits > 0xFFFFFFFFFFFF:
		milestone[gde_const.MILESTONE.ABOVE_FFFFFFFFFFFF] = true
