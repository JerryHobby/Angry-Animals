extends TextureButton

@onready var level_label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel

const HOVER_SCALE = Vector2(1.1, 1.1)
const DEFAULT_SCALE = Vector2(1.0, 1.0)

@export var level_number = 1

var level_scene: PackedScene

func _ready():
	level_label.text = str(level_number)
	level_scene = load("res://Scenes/Level/level%s.tscn" % level_number)
	score_label.text = "Best: %s" % str(ScoreManager.get_best_for_level(str(level_number)))

func _on_pressed():
	ScoreManager.set_level_selected(level_number)
	get_tree().change_scene_to_packed(level_scene)


func _on_mouse_entered():
	scale = HOVER_SCALE


func _on_mouse_exited():
	scale = DEFAULT_SCALE


