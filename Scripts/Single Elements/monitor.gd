<<<<<<< HEAD
=======
class_name Monitor
>>>>>>> origin/fazar_mekanik
extends Node2D

const GRID_SIZE: int = 32
const MONITOR_LIST = {
	'basicFaceForward' : Vector2(0, 0),
	'basicFaceDown' : Vector2(1*GRID_SIZE, 0),
	'basicFaceUp' : Vector2(2*GRID_SIZE, 0),
}
@export var spriteName: String = 'basicFaceForward'
var identityNumber = Vector2(0,0)

func _ready():
	setSprite(spriteName)
		
func setSprite(sName):
	var CUSTOM_REGION_RECT = Rect2(MONITOR_LIST[sName], Vector2(32, 32))
	$Sprite2D.region_rect = CUSTOM_REGION_RECT


