extends Area2D
#@onready var water = $Water
#
#const water_shift = 64
#enum DIRECTION {LEFT, RIGHT}
#var water_direction = DIRECTION.LEFT
@onready var splash = $Splash
#
#
#func _on_timer_timeout():
#
	#if water_direction == DIRECTION.LEFT:
		#water.position.x -= water_shift
		#water_direction = DIRECTION.RIGHT
	#else:
		#water.position.x += water_shift
		#water_direction = DIRECTION.LEFT
#
#
func _on_body_entered(body):
	splash.play()
