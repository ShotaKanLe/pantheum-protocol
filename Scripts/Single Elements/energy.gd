extends Area2D

@onready var game := get_tree().get_first_node_in_group("GameController")
@export var identityNumber: Vector2

func _on_body_entered(body):
	print(body.name)
	if body.name != "char":
		return
	game.add_energy()
	queue_free()
