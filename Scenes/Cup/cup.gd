extends StaticBody2D
@onready var animation_2d = $Animation2D

@export var item_type="cup"

func die():
	animation_2d.play("vanish")


func _on_animation_2d_animation_finished(_anim_name):
	SignalManager.on_cup_destroyed.emit()
	queue_free()
	
