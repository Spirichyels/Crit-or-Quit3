extends TextureButton
@onready var skill: TextureButton = $"."
var RAB = preload("uid://bm7xaqqy3s5p8")
var text = preload("res://Assets/SkillsIcons/skills/flamethrower.png")

@export var skill_id = 0

var max_size_x = 50
var max_size_y = 50


func setScale(x):
	scale.x = x
	scale.x = x
	

func setTextures(path):
	#var x = RAB.instantiate()
	var x = text.instantiate()
	skill.texture_normal = x
	pass
func _on_pressed() -> void:
	print("Использована способность: ",skill_id)
	pass # Replace with function body.
