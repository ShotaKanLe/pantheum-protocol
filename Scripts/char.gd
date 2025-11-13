extends Node2D

var identityNumber = Vector2(0,0)

func _ready():
	z_index = 1000
	$Timer.start(6)
	doIdleAnimation()
	pass 

func _process(delta):
	pass
	
func doBlinkAnimation():
	$AnimatedSprite2D.play("blink")
	
func doIdleAnimation():
	$AnimatedSprite2D.play("idle")

func _on_timer_timeout():
	$Timer.stop()
	doBlinkAnimation()
	await get_tree().create_timer(1.0).timeout
	doIdleAnimation()
	$Timer.start()
	
