extends Control
@onready var level_label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var level_complete_box = $MarginContainer/LevelCompleteBox
@onready var level_complete_audio = $LevelCompleteAudio
const MAIN = preload("res://Scenes/Main/main.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "Level %s" % ScoreManager.get_level_selected()
	update_attempts(0)
	SignalManager.on_score_updated.connect(update_attempts)
	SignalManager.on_level_completed.connect(on_level_completed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_packed(MAIN)


func on_level_completed():
	level_complete_box.show()
	level_complete_audio.play()


func update_attempts(attempts):
	score_label.text = "Score %s" % attempts
