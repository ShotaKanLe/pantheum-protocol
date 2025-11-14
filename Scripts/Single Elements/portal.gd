extends Node2D

const constantName = 'portal'
var identityNumber = Vector2(0,0)

@export var targetTeleport : Vector2 = Vector2(2,2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _on_area_2d_area_entered(area):
	var obj = area.get_parent()
	teleportTo(obj, targetTeleport)

func teleportTo(obj, to):
	obj.identityNumber = to
	obj.setPlayerPosition(obj.getTileInformation(obj.identityNumber))
	obj.updatePlayerInformation(to)
