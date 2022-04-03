extends Area2D


var can_move = true

var dead = false


var max_cyote_time = 0.05

var currect_cyote_time = 0

var is_cyote_queued = false

var move_direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	currect_cyote_time = max_cyote_time
	
	SignalManager.connect("tile_check_result",self,"tile_check_recieved")
	SignalManager.connect("reset_game",self,"on_game_reset")
	

func _physics_process(delta):
	
	if dead:
		return
	
	if !can_move and is_cyote_queued:
		currect_cyote_time -= delta
		if currect_cyote_time <= 0:
			is_cyote_queued = false
	elif can_move and is_cyote_queued:
		move_to(position + 16 * move_direction)
		is_cyote_queued = false
		
		pass
	
	


func _input(event):
	
	if dead:
		return
	
	if event is InputEventKey and !event.is_echo() and event.is_pressed() and !is_cyote_queued:
		
		if event.is_action_pressed("up"):
			move_direction = Vector2.UP
			if $UpCast.is_colliding() and $UpCast.get_collider().is_in_group("Block"):
				tile_check_recieved(false, move_direction + position)
		elif event.is_action_pressed("down"):
			move_direction = Vector2.DOWN
			if $DownCast.is_colliding() and $DownCast.get_collider().is_in_group("Block"):
				tile_check_recieved(false, move_direction + position)
				pass
		elif event.is_action_pressed("left"):
			move_direction = Vector2.LEFT
			if $LeftCast.is_colliding() and $LeftCast.get_collider().is_in_group("Block"):
				tile_check_recieved(false, move_direction + position)
				pass
		elif event.is_action_pressed("right"):
			move_direction = Vector2.RIGHT
			if $RightCast.is_colliding() and $RightCast.get_collider().is_in_group("Block"):
				tile_check_recieved(false, move_direction + position)
				pass
		else:
			return
		
		if  can_move:
			move_to(position + 16 * move_direction)
		else:
			is_cyote_queued = true
			currect_cyote_time = max_cyote_time
	

func move_to(target_position):
	SignalManager.emit_signal("check_tile",target_position)
	

func tile_check_recieved(result, target_position):
	can_move = false
	if result:
		$Tween.interpolate_property(self,"position",position,target_position,0.15,Tween.TRANS_EXPO,Tween.EASE_OUT)
	else:
		$Tween.interpolate_property(self,"position",position + (target_position - position).normalized() * 4, position, 0.125, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()


func on_game_reset():
	collision_layer = 1
	collision_mask = 1
	dead = false

func _on_Tween_tween_completed(object, key):
	can_move = true


func _on_Player_area_entered(area):
	if area.is_in_group("Obstacle"):
		collision_layer = 0
		collision_mask = 0
		SignalManager.emit_signal("player_dead")
		SignalManager.emit_signal("trigger_transition", Global.repeted_dialogue,-1)
