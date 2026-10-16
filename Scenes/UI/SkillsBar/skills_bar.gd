extends HBoxContainer

@onready var skill_1: TextureButton = $Skill1
@onready var skill_2: TextureButton = $Skill2
@onready var skill_3: TextureButton = $Skill3
@onready var skill_4: TextureButton = $Skill4



var skills = []


func _ready() -> void:
	

	skills.push_front(skill_4)
	skills.push_front(skill_3)
	skills.push_front(skill_2)
	skills.push_front(skill_1)
	
	await get_tree().process_frame
	for i in skills:
		#print(i.size.x) #размер Enemy
		pass
	
	


func _on_resized() -> void:
	if size.x > 400:
		for i in skills:
			print(i.scale/2)
			i.setScale(0.1)
	
		size.x = 400
	
		
	pass # Replace with function body.
