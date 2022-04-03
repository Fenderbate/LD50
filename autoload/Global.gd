extends Node


var first_start = true

var attack_stage_index = 0
var stage_step_index = 0
var dialogue_index = 0

var attack_in_progress = false

var spike = preload("res://scenes/spike/Spike.tscn")
var block = preload("res://scenes/block/Block.tscn")


var repeted_dialogue = [
	"Again!",
	"Pathetic!",
	"Be quicker!",
	"Dodge that one too!",
	"Was that on purpose?",
	"Is this challenging?",
	"Fool!"
]

var intro_text = [
	#["start_attacks"],
	"Let's see...",
	"Another nobody,\n blessed with immortality.",
	"Let's see if you're soilder material.",
	"If not, you will be.",
	"Either through will...",
	"...or force.",
	"You have no choice.",
	["attack_start"]
]

var attack_stage_dialogues = {
	"stage0": ["Next!",["attack_start"]],
	"stage1": ["Keep going!",["attack_start"]],
	"stage2": ["At least you're \n not a complete dolt.", ["attack_start"]],
	"stage3": ["Let's step it up a bit.", ["attack_start"]],
	"stage4": ["Prepare yourself!", "This is the last one.", ["attack_start"]],
	"stage5": ["Congratulations.", "You made it through.", "Leave through the gate, \n join the others \n and start training.",
				"What?", "You don't want to be a soilder?", "You don't have a choice.", "If you don't join the rest...","...you would only get tortured...",
				"...then break, and accept your fate.", "And I'm sure you don't want that.", "Now move along!", ["game_end"]]
}

var game_end_message = "And thus, your life as a soilder begins. \n There is no use of running, or opposing your superiors. \n That would only\n DELAY THE INEVITABLE"

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("player_dead",self,"on_player_dead")


func on_player_dead():
	attack_stage_index = 0
	stage_step_index = 0
	dialogue_index = 0
	attack_in_progress = false
	pass
