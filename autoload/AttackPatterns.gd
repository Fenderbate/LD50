extends Node

var char_codes = {
	"empty" : 'e',
	"spike" : 's',
	"block" : 'b',
	"next"  : '-'
}

var patterns = {
	"spike_attack1" : "eeeee-esese-eesee-esese-eeeee",
	"spike_attack2" : "eeeee-eesee-esese-eesee-eeeee",
	"spike_attack3" : "eeeee-essse-esese-essse-eeeee",
	
	"block_attack1" : "eeeee-ebbbe-ebebe-ebbbe-eeeee",
	"block_attack2" : "eeeee-ebbbe-ebbbe-ebbbe-eeeee",
	
	"spike_attack4" : "eeeee-essee-eeeee-eeeee-eeeee",
	"spike_attack5" : "eeeee-eeese-eeese-eeeee-eeeee",
	"spike_attack6" : "eeeee-eeeee-essee-eeeee-eeeee",
	"spike_attack7" : "eeeee-eeeee-eeeee-essee-eeeee",
	"spike_attack8" : "eeeee-eeeee-eeese-eeese-eeeee",
	"spike_attack9" : "eeeee-eeeee-essee-eeeee-eeeee",
	"spike_attack10" : "eeeee-essse-eeeee-eeeee-eeeee",
	
	"mix_attack1" : "eeeee-eseee-eebee-eeese-eeeee",
	"mix_attack2" : "eeeee-eesee-eeeee-eesee-eeeee",
	"mix_attack3" : "eeeee-eeese-eebee-eseee-eeeee",
	"mix_attack4" : "eeeee-eeeee-esese-eeeee-eeeee",
	"mix_attack5" : "eeeee-ebebe-esese-ebebe-eeeee",
	"mix_attack6" : "eeeee-eesee-essse-eesee-eeeee",
	"mix_attack7" : "eeeee-eseee-essse-eeese-eeeee",
	
	"hard_attack1" : "eeeee-eesse-essse-essee-eeeee",
	"hard_attack2" : "eeeee-eeebe-eebee-ebeee-eeeee",
	"hard_attack3" : "eeeee-essee-esese-eesse-eeeee",
	"hard_attack4" : "eeeee-eeese-essse-eseee-eeeee",
	"hard_attack5" : "eeeee-ebbee-eebee-eebbe-eeeee",
	"hard_attack6" : "eeeee-eesee-essse-eesee-eeeee",
	"hard_attack7" : "eeeee-ebbbe-ebebe-ebbbe-eeeee",
	
	
}



var attack_stages = {
	"stage0" : [["spike_attack1", 0], ["spike_attack2", 1], ["spike_attack3", 1], ["spike_attack1", 1],"o"],
	"stage1" : [["block_attack2", 0, 0.5],"o"],
	"stage2" : [["spike_attack4", 1], ["spike_attack5", 1], ["spike_attack6", 1], ["spike_attack7", 1], ["spike_attack8", 1],["spike_attack9", 1],["spike_attack10", 1],"o"],
	"stage3" : [["mix_attack1", 0.75], ["mix_attack2", 0.75], ["mix_attack3", 0.75], ["mix_attack4", 0.75], ["mix_attack5", 0.75],["mix_attack6", 1.2],["mix_attack7", 1],"o"],
	"stage4" : [["hard_attack1", 0.75], ["hard_attack2", 0.75], ["hard_attack3", 0.75], ["hard_attack4", 0.75], ["hard_attack5", 0.75],["hard_attack6", 0.75],["hard_attack7", 0.75],"o"]
}
