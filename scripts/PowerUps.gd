extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_JumpPowerUp_body_entered(body):
	queue_free()
	if body.is_in_group("Player"):
		Global.player_powerups["DoubleJump"] = true
		#body.set_doublejump(true)
