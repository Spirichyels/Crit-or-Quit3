extends Node

signal hp_changed()


var PLAYER_CURRENT_HP = 10:
	set(value):
		PLAYER_CURRENT_HP = value
		emit_signal("hp_changed")
		
var PLAYER_MAX_HP = 10:
	set(value):
		PLAYER_MAX_HP = value
		emit_signal("hp_changed")

var PLAYER_SCORE = 0
