extends Area2D


# Declare member variables here. Examples:
# var a = 2
var bars = 0
var speed = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var move = Vector2()
	if bars >= 30:
		speed = -speed
		bars = 0
	bars += 1
	move.y = speed
	position += move * delta

func _on_JumpPowerUp_body_entered(body):
	queue_free()
	if body.is_in_group("Player"):
		Global.player_powerups["DoubleJump"] = true
		#body.set_doublejump(true)
