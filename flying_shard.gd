extends Node2D

signal finished

onready var shard_amt = find_node("shard_amt")
onready var shard_sprite = find_node("shard_sprite")

export(int) var shard_speed = 375

var shard_count = 0
var finished = true
var from = Vector2()
var to = Vector2()

func _ready():
	pass

func _process(delta):
	if not finished:
		var dist_to_move = shard_speed * delta
		position += (to - from).normalized() * dist_to_move
		
		if position.distance_squared_to(to) < (dist_to_move * dist_to_move):
			position = to
			emit_signal("finished", self, shard_count)

func set_from_to(from:Vector2, to:Vector2):
	finished = false
	position = from
	self.from = from
	self.to = to

func set_shard_amount(new_amount):
	shard_count = new_amount
	shard_amt.text = "%X" % shard_count

