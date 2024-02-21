extends RigidBody2D
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var label = $Label
@onready var stretch_sound = $StretchSound
@onready var arrow = $Arrow
@onready var launch_sound = $LaunchSound


enum ANIMAL_STATE { READY, DRAG, RELEASE }
var _state = ANIMAL_STATE.READY

const DRAG_LIMIT_MAX = Vector2(0, 60)
const DRAG_LIMIT_MIN = Vector2(-60, 0)
const IMPULSE_MULT = 20.0
const IMPULSE_MAX = 1200.0

var _start = Vector2.ZERO
var _drag_start = Vector2.ZERO
var _dragged_vector = Vector2.ZERO
var _last_dragged_vector = Vector2.ZERO
var _arrow_scale_x = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	_start = position
	_arrow_scale_x = arrow.scale.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	update(delta)

func get_impulse() -> Vector2:
	return _dragged_vector * IMPULSE_MULT * -1
	
	
func update(delta):
	label.text = "%s\n" % ANIMAL_STATE.keys()[_state]
	label.text += "%.1f, %.1f" % [_dragged_vector.x, _dragged_vector.y]
	
	match _state:
		ANIMAL_STATE.READY:
			update_ready(delta)
			
		ANIMAL_STATE.DRAG:
			update_drag(delta)
			
		ANIMAL_STATE.RELEASE:
			update_release(delta)
			
		_:
			print("Invalid animal_state")
			pass


func update_ready(delta):
	pass


func scale_arrow():
	var imp_len = get_impulse().length()
	var perc = imp_len / IMPULSE_MAX
	arrow.rotation = (_start - position).angle()
	arrow.scale.x = (_arrow_scale_x * perc) + _arrow_scale_x


func play_stretched_sound():
	if( _last_dragged_vector - _dragged_vector).length() > 0:
		if stretch_sound.playing == false:
			stretch_sound.play()


func get_dragged_vector(gmp:Vector2) -> Vector2:
	return gmp - _drag_start


func dragged_in_limits():
	_last_dragged_vector = _dragged_vector
	
	_dragged_vector.x = clampf(
		_dragged_vector.x,
		DRAG_LIMIT_MIN.x,
		DRAG_LIMIT_MAX.x
	)
	_dragged_vector.y = clampf(
		_dragged_vector.y,
		DRAG_LIMIT_MIN.y,
		DRAG_LIMIT_MAX.y
	)
	position = _start + _dragged_vector


func update_drag(delta):
	if detect_release():
		return

	var gmp = get_global_mouse_position()
	_dragged_vector = get_dragged_vector(gmp)
	dragged_in_limits()
	play_stretched_sound()
	scale_arrow()



func update_release(delta):
	pass


func detect_release() -> bool:
	if _state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("drag"):
			set_state(ANIMAL_STATE.RELEASE)
			return true
	return false


func set_drag() -> void:
	_drag_start = get_global_mouse_position()
	arrow.show()


func set_release() -> void:
	arrow.hide()
	freeze = false
	apply_central_impulse(get_impulse())
	launch_sound.play()
	SignalManager.on_attempt_made.emit()


func set_state(new_state: ANIMAL_STATE) -> void:
	_state = new_state
	if _state == ANIMAL_STATE.RELEASE:
		set_release()
	elif _state == ANIMAL_STATE.DRAG:
		set_drag()


func _on_visible_on_screen_notifier_2d_screen_exited():
	die()


func die():
	SignalManager.on_animal_died.emit()
	queue_free()


func _on_input_event(viewport, event:InputEvent, shape_idx):
	if _state == ANIMAL_STATE.READY \
	and event.is_action_pressed("drag"):
		set_state(ANIMAL_STATE.DRAG)


