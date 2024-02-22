extends RigidBody2D
@onready var label = $Label

@onready var bird = $"../Bird"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sleeping or freeze:
		label.text = "Zzzzz"
	else:
		label.text = "Bouncing"



func _on_timer_timeout():
	freeze = false



func _on_bird_input_event(viewport, event, shape_idx):
	if event.button_mask == 1:
		bird.position = event.position
		#print (event.position)
	#print(event)
	#if event
		#position = get_global_mouse_position()

