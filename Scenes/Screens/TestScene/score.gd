extends Label

func _ready() -> void:
	Global.connect("score_changed", Callable(self, "_score_changed"))
	
func _score_changed():
	if Global.PLAYER_CURRENT_HP > 0:
		#print("Очков: ", Global.SCORE)
		text = "Очков: "+ str(Global.SCORE)
