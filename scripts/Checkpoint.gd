extends Area2D

var activate_checkpoint = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		if activate_checkpoint:
			body.set_spawn_position(self.position)
			activate_checkpoint = false
	
