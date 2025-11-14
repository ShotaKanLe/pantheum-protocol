extends Area2D

const constantName = 'EnergyCore'

func _ready():
	z_index = 1000
	$Animasi.play("idle")

func touchCore(body):
	if body.name == "char":
		$Animasi.play("pickup")
		$CollisionShape2D.set_deferred("disabled", true)
		Global.COUNT_ENERGY += 1
		print(Global.COUNT_ENERGY)
		
		await get_tree().create_timer(0.3).timeout
		queue_free()
