extends Node

# Declare member variables here. Examples:
# var a = 2
var settings = {"Music": true, "SoundEffects": true}
var player_powerups = {"DoubleJump": false, "Small":false}
var keys={"bus":false,"sewer":false,"train":false}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func reset_player_powerups():
	player_powerups = {"DoubleJump": false, "Small":false}

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
