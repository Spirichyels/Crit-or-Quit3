extends Node2D



enum SCENE {
	INITIAL,
	GAME,
	PAUSE,
	END
}

var scene_state = SCENE.INITIAL:
	set(value):
		match scene_state:
			SCENE.INITIAL:
				pass
			SCENE.GAME:
				pass
			SCENE.PAUSE:
				pass
			SCENE.END:
				pass

func _ready() -> void:

	pass
	
