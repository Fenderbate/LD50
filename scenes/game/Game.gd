extends Node2D

var reset = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("check_tile",self,"on_tile_check")
	SignalManager.connect("player_dead",self,"on_player_dead")
	SignalManager.connect("stop_game",self,"on_game_stopped")
	SignalManager.connect("reset_game",self,"on_game_reset")
	
	SignalManager.connect("start_stage_attack",self,"on_stage_attack_start")
	SignalManager.connect("attack_start",self,"on_attack_start")
	SignalManager.connect("attack_end",self,"on_attack_end")
	SignalManager.connect("next_stage_attack",self,"on_next_stage_attack")
	
	SignalManager.emit_signal("trigger_transition",["Let's begin!"],0)
	
	yield(get_tree().create_timer(3),"timeout")
	SignalManager.emit_signal("dialogue_start",Global.intro_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func spawn_obstacle(attack_layout_text, delay = 0):
	
	if reset:
		return
	
	var tile_index = Vector2(-3,-2)
	
	for letter in attack_layout_text:
		
		if reset:
			return
		
		var use_delay = false
		if letter == AttackPatterns.char_codes["empty"]:
			pass
		elif letter == AttackPatterns.char_codes["spike"]:
			spawn_spike(tile_index * 16)
			use_delay = true
		elif letter == AttackPatterns.char_codes["block"]:
			spawn_block(tile_index * 16)
			use_delay = true
		elif letter == AttackPatterns.char_codes["next"]:
			tile_index.y += 1
			tile_index.x = -3
		else:
			print("unrecognized letter in attack patterns:  ",letter)
			print("ERRRRRRRRRRRRRRR")
		tile_index.x += 1
		if use_delay == true:
			yield(get_tree().create_timer(delay),"timeout")
	
	SignalManager.emit_signal("next_stage_attack")
	
	#var index = randi() % $TileMap.get_used_cells().size()
	
	#var pos = $TileMap.get_used_cells()[index] * 16
	
	pass
	
func spawn_spike(spawn_position):
	var spike = Global.spike.instance()
	spike.position = spawn_position
	add_child(spike)

func spawn_block(spawn_position):
	var block = Global.block.instance()
	block.position = spawn_position
	add_child(block)


func on_tile_check(position):
	
	
	if $TileMap.get_cell(position.x/16, position.y/16) > -1:
		SignalManager.emit_signal("tile_check_result", true, position)
	else:
		SignalManager.emit_signal("tile_check_result", false, position)
	

func on_player_dead():
	reset = true
	$AttackEndTimer.stop()
	

func on_game_stopped():
	for object in get_tree().get_nodes_in_group("Obstacle"):
		object.queue_free()
	$Player.position = Vector2()

func on_game_reset():
	reset = false
	SignalManager.emit_signal("attack_start")


func on_attack_start():
	
	Global.attack_in_progress = true
	
	var stage_step = AttackPatterns.attack_stages[str("stage",Global.attack_stage_index)][Global.stage_step_index]
	
	if stage_step is String:
		SignalManager.emit_signal("attack_end")
	else:
		if reset:
			return
		yield(get_tree().create_timer(stage_step[1]),"timeout")
		if stage_step.size() == 3:
			spawn_obstacle(AttackPatterns.patterns[stage_step[0]], stage_step[2])
		else:
			spawn_obstacle(AttackPatterns.patterns[stage_step[0]])
	
	
	pass

func on_attack_end():
	
	if !reset:
		Global.attack_in_progress = false
		$AttackEndTimer.start()
		Global.attack_stage_index += 1
		Global.stage_step_index = 0
		

func on_next_stage_attack():
	Global.stage_step_index += 1
	
	SignalManager.emit_signal("attack_start")

	
	#if switch:
	#	spawn_obstacle(AttackPatterns.spike_patterns["attack1"])
	#else:
	#	spawn_obstacle(AttackPatterns.spike_patterns["attack2"])
	#switch = !switch



func _on_AttackEndTimer_timeout():
	SignalManager.emit_signal("dialogue_start",Global.attack_stage_dialogues[str("stage",Global.attack_stage_index)])
