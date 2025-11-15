extends Area2D
class_name Hidden
@export var identityNumber: Vector2
@onready var animated_sprite_2d = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_anim():
	animated_sprite_2d.play("default")
	
func _on_body_entered(body):
	Global.energy = 0
	print("Hidden collided with: ", body)
	print("Game Over")
	get_tree().reload_current_scene()
