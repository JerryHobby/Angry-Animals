extends Node2D
const ANIMAL = preload("res://Scenes/Animal/animal.tscn")
@onready var animal_start_marker = $AnimalStartMarker
const MAIN = preload("res://Scenes/Main/main.tscn")
var animal


# Called when the node enters the scene tree for 
# the first time.
func _ready():
	animal = add_animal()
	SignalManager.on_animal_died.connect(on_animal_died)


# Called every frame. 'delta' is the elapsed time 
# since the previous frame.
func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_packed(MAIN)


func on_animal_died():
	add_animal()


func add_animal():
	var new_animal = ANIMAL.instantiate()
	new_animal.position = animal_start_marker.position
	add_child(new_animal)

	return animal

