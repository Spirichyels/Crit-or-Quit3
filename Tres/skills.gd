extends Node

var SKILL_0 = preload("uid://co88pcn5nawr5")
var SKILL_1 = preload("uid://u1t5ddxs2714")




var skills = []
var COUNT_SKILLS = 0


func _ready() -> void:
	skills.push_front(SKILL_0)
	skills.push_front(SKILL_1)
	
	for el in skills.size():
		print(skills[el].id)
