extends Area2D

class_name Escalator
@export var identityNumber : Vector2
@onready var animated_sprite_2d = $AnimationPlayer

@export var direction : String = 'up'
@onready var game = get_tree().get_first_node_in_group("GameController")
var active = true

func setDirectionAnimation():
	if direction == 'up':
		$Sprite2D.rotation_degrees = -90
		$Sprite2D.scale = Vector2(0.05, 0.1)
	if direction == 'down':
		$Sprite2D.rotation_degrees = 90
		$Sprite2D.scale = Vector2(0.05, 0.1)
	if direction == 'left':
		$Sprite2D.flip_h = true

func _ready():
	setDirectionAnimation()
	if active:
		animated_sprite_2d.play("idle")

func _on_body_entered(body):
	# Pastikan yang masuk adalah karakter pemain
	if body.name != "char": 
		return
		
	# Pastikan karakter sudah bergerak dan tidak dalam cooldown
	if game.portal_cooldown: # Asumsi: Anda punya cooldown di GameController
		return

	escalateTo(body, direction)
	

func escalateTo(obj, direction):
	if active:
		# 1. Ambil posisi karakter saat ini (salinan otomatis di Godot 4)
		var current_pos = obj.identityNumber
		
		# 2. Tentukan posisi tujuan dari Escaltor (SATU LANGKAH DARI POSISI KARAKTER SAAT INI)
		var target_pos = current_pos
		
		# 3. Hitung target posisi
		if direction == 'up':
			target_pos.y -= 1
		elif direction == 'down':
			target_pos.y += 1
		elif direction == 'left':
			target_pos.x -= 1
		elif direction == 'right':
			target_pos.x += 1
		
		# 4. Verifikasi dan Eksekusi di GameController (seperti Portal)
		
		# Cek apakah target_pos berada di dalam batas grid dan apakah tile bisa diinjak
		if game.is_walkable(target_pos) or game.check_if_portal(target_pos): 
			# Panggil fungsi teleportasi yang sudah ada di GameController
			game.teleport_player(target_pos) 
		else:
			# Pilihan: Jika target terblokir, karakter tetap diam di escalator
			pass
		
func activated():
	active = true
	animated_sprite_2d.play("idle")

func deactivated():
	active = false
	$AnimationPlayer.stop()
