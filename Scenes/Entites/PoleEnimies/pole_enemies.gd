extends Control
@onready var enemie_9: Control = $MC/VBC/LineTop/Enemie9
@onready var enemie_8: Control = $MC/VBC/LineTop/Enemie8
@onready var enemie_7: Control = $MC/VBC/LineTop/Enemie7
@onready var enemie_6: Control = $MC/VBC/LineCenter/Enemie6
@onready var enemie_5: Control = $MC/VBC/LineCenter/Enemie5
@onready var enemie_4: Control = $MC/VBC/LineCenter/Enemie4
@onready var enemie_3: Control = $MC/VBC/LineDown/Enemie3
@onready var enemie_2: Control = $MC/VBC/LineDown/Enemie2
@onready var enemie_1: Control = $MC/VBC/LineDown/Enemie1

var enemies = []
enum {
	IDLE,
	ATTACK,
	TIME_BLOCK,
	DAMAGE,
	DEATH,
	REBORN,
	INITIAL
}


func _ready() -> void:
	enemies.push_back(enemie_9)
	enemies.push_back(enemie_8)
	enemies.push_back(enemie_7)
	enemies.push_back(enemie_6)
	enemies.push_back(enemie_5)
	enemies.push_back(enemie_4)
	enemies.push_back(enemie_3)
	enemies.push_back(enemie_2)
	enemies.push_back(enemie_1)
	
	await get_tree().process_frame
	for i in enemies:
		#print(i.size.x) #размер Enemy
		i.update_sizes()
		i.state = INITIAL
		print("onDeath: ",i.onDeath)
		

func _process(delta: float) -> void:
	#print(randi_range(0,8))
	pass
	#print(enemie_1.size)
	#for i in enemies:
		#print(i.size.x)
		#i.update_sizes()
		
	


func _on_timer_on_attack_timeout() -> void:
	#enemies[randi_range(0,8)].state = ATTACK
	var enemy = enemies[randi_range(0,8)]
	if enemy.onDeath:
		enemy.state = REBORN
	
	pass # Replace with function body.
