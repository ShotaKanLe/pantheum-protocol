extends Node2D

var condition
const constantName = 'Vault'

func _ready():
	condition = false
	z_index = 1000
	$AnimateSprite2D.play("idle")
	
func _process(delta):
	if Global.COUNT_ENERGY == 3:
		$AnimateSprite2D.play("open")
		condition = true

func touchVault(body):
	if body.name == "char" and condition == true:	
		get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")
