extends Node


export(NodePath) var game_dialogue_label = null

var dialogue_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("dialogue_start",self,"on_dialogue_start")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_dialogue_start(text):
	dialogue_active = true
	display_text(text)
	pass


func display_text(text_array):
	var label = get_node(game_dialogue_label)
	
	for text in text_array:
		if text is Array:
			SignalManager.emit_signal(text[0])
		else:
			label.text = ""
			for letter in text:
				label.text += letter
				$SpeechEffects.get_children()[randi() % $SpeechEffects.get_child_count()].play()
				yield(get_tree().create_timer(0.05),"timeout")
			yield(get_tree().create_timer(2),"timeout")
	
	dialogue_active = false
	Global.first_start = false
	label.text = ""
	
	
	
	
