extends Node

signal hp_changed()
signal score_changed()



var PLAYER_CURRENT_HP = 10:
	set(value):
		PLAYER_CURRENT_HP = value
		emit_signal("hp_changed")
		
var PLAYER_MAX_HP = 10:
	set(value):
		PLAYER_MAX_HP = value
		emit_signal("hp_changed")
		
var SCORE = 0:
	set(value):
		SCORE = value
		emit_signal("score_changed")

var DIFFICULTY = 0:
	set(value):
		DIFFICULTY = value

var PLAYER_SCORE = 0
