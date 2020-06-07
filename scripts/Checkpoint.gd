extends Area2D

var activate_checkpoint = true

var bars = 0
var speed = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var move = Vector2()
	if bars >= 30:
		speed = -speed
		bars = 0
	bars += 1
	move.y = speed
	position += move * delta

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		#if activate_checkpoint:
		queue_free()
		body.set_spawn_position(self.position)
		#activate_checkpoint = false
	
