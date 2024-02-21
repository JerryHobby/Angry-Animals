extends Node2D
const ANIMAL = preload("res://Scenes/Animal/animal.tscn")
@onready var animal_start_marker = $AnimalStartMarker

var animal


# Called when the node enters the scene tree for 
# the first time.
func _ready():
	animal = add_animal()
	SignalManager.on_animal_died.connect(on_animal_died)


# Called every frame. 'delta' is the elapsed time 
# since the previous frame.
func _process(delta):
	pass


func on_animal_died():
	add_animal()


func add_animal():
	var animal = ANIMAL.instantiate()
	animal.position = animal_start_marker.position
	add_child(animal)

	return animal
