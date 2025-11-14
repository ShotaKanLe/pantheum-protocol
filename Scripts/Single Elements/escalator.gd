extends Node2D

const constantName = 'escalator'
var identityNumber : Vector2 = Vector2(0,0)

@export var direction : String = 'down'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _on_area_2d_area_entered(area):
	var obj = area.get_parent()
	escalateTo(obj, direction)

func escalateTo(obj, direction):
	var tempIdentityNumber = identityNumber
	
	if direction == 'up':
		tempIdentityNumber.y -= 1
	elif direction == 'down':
		tempIdentityNumber.y += 1
	elif direction == 'left':
		tempIdentityNumber.x -= 1
	elif direction == 'right':
		tempIdentityNumber.x += 1
	
	obj.identityNumber = tempIdentityNumber
	obj.setPlayerPosition(obj.getTileInformation(obj.identityNumber))
	obj.updatePlayerInformation(tempIdentityNumber)
