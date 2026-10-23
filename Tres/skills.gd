extends Node

var SKILL_0 = preload("uid://co88pcn5nawr5")
var SKILL_1 = preload("uid://u1t5ddxs2714")
var SKILL_2 = preload("uid://4rxfbbxgrge")



enum TYPE_TARGET {
	MASS_DAMAGE,
	TARGET_DAMAGE
}

enum TYPE_DAMAGE {
	STATIC_DAMAGE,
	DLITELN_DAMAGE,
	HEAL
}

var skills = []
var COUNT_SKILLS = 0


func _ready() -> void:
	skills.push_front(SKILL_2)
	skills.push_front(SKILL_1)
	skills.push_front(SKILL_0)
	
	
	
	for el in skills.size():
		#print(skills[el].id)
		pass
