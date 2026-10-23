extends HBoxContainer

@onready var skill_Button_1: TextureButton = $SkillButton1
@onready var skill_Button_2: TextureButton = $SkillButton2
@onready var skill_Button_3: TextureButton = $SkillButton3
@onready var skill_Button_4: TextureButton = $SkillButton4
@onready var skill_Button_5: TextureButton = $SkillButton5
@onready var skill_Button_6: TextureButton = $SkillButton6




var skills_Button = []


func _ready() -> void:
	
	#skills_Button.push_front(skill_Button_6)
	#skills_Button.push_front(skill_Button_5)
	#skills_Button.push_front(skill_Button_4)
	skills_Button.push_front(skill_Button_3)
	skills_Button.push_front(skill_Button_2)
	skills_Button.push_front(skill_Button_1)
	
	await get_tree().process_frame
	#print(Skills.skills[0].icon.resource_path)

	skills_Button[0].setSkill(0)
	skills_Button[1].setSkill(1)
	skills_Button[2].setSkill(2)
	
	for i in skills_Button:
		#print(i.size.x) #размер Enemy
		pass


func _on_resized() -> void:
	#if size.x > 400:
		#for i in skills:
			#print(i.scale/2)
			#i.setScale(0.1)
	#
		#size.x = 400
	
		
	pass # Replace with function body.
