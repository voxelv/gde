extends Node2D

signal shard_finished

var flying_shard_preload = preload("res://flying_shard.tscn")

func _ready():
	pass

func new_flying_shard(world_start:Rect2, world_end:Rect2, amount):
	var from = Vector2(rand_range(world_start.position.x, world_start.end.x), rand_range(world_start.position.y, world_start.end.y))
	var to = Vector2(rand_range(world_end.position.x, world_end.end.x), rand_range(world_end.position.y, world_end.end.y))
	var shard = flying_shard_preload.instance()
	add_child(shard)
	shard.set_shard_amount(amount)
	shard.set_from_to(from, to)
	shard.connect("finished", self, "_on_shard_finished")

func _on_shard_finished(shard, amount):
	remove_child(shard)
	emit_signal("shard_finished", amount)