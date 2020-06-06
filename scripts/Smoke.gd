extends Node2D



func _ready():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="blow":
		LevelManager.change_level()
