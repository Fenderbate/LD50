extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.attack_in_progress:
		$AnimationPlayer.play("warning")
	else:
		queue_free()

func play_audio():
	$Spike.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
