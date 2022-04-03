extends Node

signal trigger_transition(text_array, index)

signal check_tile(world_position)
signal tile_check_result(result, world_position)

signal player_dead()

signal stop_game()
signal reset_game()


signal start_dialogue(text)

signal start_stage_attack()
signal attack_start()
signal attack_end()
signal next_stage_attack()

signal dialogue_start(dialogue_text_array)

signal game_end()
