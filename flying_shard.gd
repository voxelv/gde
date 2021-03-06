extends Node2D

signal finished

onready var shard_amt = find_node("shard_amt")
onready var shard_sprite = find_node("shard_sprite")

export(int) var shard_speed_min = 350
export(int) var shard_speed_max = 650

var shard_count = 0
var finished = true
var from = Vector2()
var to = Vector2()
var rotation_speed = 0.0
var move_speed = 0

func _ready():
	randomize()
	rotation_speed = 270
	if randi() % 2 == 0:
		rotation_speed *= -1
	move_speed = shard_speed_min

func _process(delta):
	if not finished:
		var dist_to_move = move_speed * delta
		position += (to - from).normalized() * dist_to_move
		shard_sprite.rotate(deg2rad(rotation_speed) * delta)
		
		if position.distance_squared_to(to) < (dist_to_move * dist_to_move):
			position = to
			emit_signal("finished", self, shard_count)

func set_from_to(from:Vector2, to:Vector2):
	finished = false
	position = from
	self.from = from
	self.to = to

func set_shard_amount(new_amount):
	if new_amount > player_data.highest_shard_value:
		player_data.highest_shard_value = new_amount
		print(new_amount)
	move_speed = shard_speed_max - ((new_amount / player_data.highest_shard_value) * (shard_speed_max - shard_speed_min))
	shard_count = new_amount
	shard_amt.text = "%X" % shard_count

