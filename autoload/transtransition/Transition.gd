extends CanvasLayer


var sequence_index = 0

var game_end = false


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("trigger_transition",self,"on_transition_triggered")
	SignalManager.connect("game_end",self,"on_game_end")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func on_transition_triggered(text_array, index):
	if Global.first_start:
		$AnimationPlayer.play("game_start")
	else:
			
		if index < 0:
			$Shader/Label.text = text_array[randi() % text_array.size()]
		else:
			$Shader/Label.text = text_array[index]
		
		$AnimationPlayer.play("fade_in")


func _on_AnimationPlayer_animation_finished(anim_name):
	if Global.first_start:
		if anim_name == "game_start":
			$AnimationPlayer.play("text_float_out")
		elif anim_name == "text_float_out":
			$AnimationPlayer.play("fade_out")
		elif anim_name == "fade_out":
			pass
	else:
		if anim_name == "fade_in":
			$AnimationPlayer.play("text_float_in")
		elif anim_name == "text_float_in":
			if game_end:
				return
			SignalManager.emit_signal("stop_game")
			$AnimationPlayer.play("text_float_out")
		elif anim_name == "text_float_out":
			$AnimationPlayer.play("fade_out")
		elif anim_name == "fade_out":
			SignalManager.emit_signal("reset_game")
	

func on_game_end():
	game_end = true
	SignalManager.emit_signal("trigger_transition",[Global.game_end_message],0)
