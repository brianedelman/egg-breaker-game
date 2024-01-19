extends RigidBody2D

class_name Brick

signal brick_destroyed

var level = 1

var sprites: Array[Texture2D] = [
	preload("res://graphics/objects/ventilation_surface_small.png"),
	preload("res://graphics/objects/block2.png"),
	preload("res://graphics/objects/block3.png"),
	preload("res://graphics/objects/block4.png"),
	preload("res://graphics/objects/block5.png"),
	preload("res://graphics/objects/block6.png"),
]

func get_size():
	return $CollisionShape2D.shape.get_rect().size
	
func set_level(new_level: int):
	level = new_level
	$Sprite2D.texture = sprites[new_level - 1]
	
func decrease_level():
	if level > 1:
		set_level(level - 1)
	else:
		fade_out()
		
func fade_out():
	$CollisionShape2D.disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.TRANSPARENT, .5)
	tween.tween_callback(destroy)
	
	
func destroy():
 # Play audio here
	var audio_stream_player = $AudioStreamPlayer
	audio_stream_player.play()
	
	queue_free()
	brick_destroyed.emit()
	
func get_width():
	return get_size().x
