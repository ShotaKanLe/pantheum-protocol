class_name Monitor
extends Node2D

var MONITOR_LIST = {
	'defaultMid' : load("res://Assets/TV/default/defaultMid.png"),
}
@export var spriteName: String = 'basicFaceForward'
var identityNumber = Vector2(0,0)

func _ready():
	setSprite(spriteName)
		
func setSprite(sName):
	$Sprite2D.texture = MONITOR_LIST[sName]


