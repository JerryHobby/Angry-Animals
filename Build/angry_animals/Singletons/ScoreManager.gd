extends Node

var _level_selected:int = 0
var _level_scores = {}
const DEFAULT_SCORE = 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func set_level_selected(level):
	_level_selected = level


func get_level_selected() -> int:
	return _level_selected


func check_and_add_key(level:String):
	if _level_scores.has(level) == false:
		_level_scores[level] = DEFAULT_SCORE


func set_score_for_level(score, level:String):
	check_and_add_key(level)
	if _level_scores[level] > score:
		_level_scores[level] = score


func get_best_for_level(level:String) -> int:
	check_and_add_key(level)
	return _level_scores[level]
