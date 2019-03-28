extends Node

const WORKERS_PER_GROUP = 4

enum MILESTONE {
	ABOVE_0, 
	REACHED_10, 
	ABOVE_FFFF, 
	ABOVE_FFFFFFFF, 
	ABOVE_FFFFFFFFFFFF, 
	COUNT}

const WORD_INDEX_TO_MILESTONE = [MILESTONE.ABOVE_FFFFFFFFFFFF, MILESTONE.ABOVE_FFFFFFFF, MILESTONE.ABOVE_FFFF, MILESTONE.ABOVE_0]
