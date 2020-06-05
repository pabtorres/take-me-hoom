extends Node2D



var instance


const bullet_obj = preload("res://scenes/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	instance=null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if LevelManager.enemy_must_be_instantiated:
		var children= get_tree().get_root().get_children()
		var instance=null
		for child in children:
			if child.name=="FoxLeft":
				instance=child
				print(instance)
				get_tree().get_root().remove_child(instance)
		var bullet_inst = bullet_obj.instance()
		get_tree().get_root().add_child(bullet_inst)
		bullet_inst.global_position = global_position
		LevelManager.enemy_must_be_instantiated=false
		
