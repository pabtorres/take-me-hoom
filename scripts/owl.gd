extends Area2D

var time=0
var velocity
const bullet_obj = preload("res://scenes/Tornado.tscn")

var facing_right = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func take_damage():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if time==100:
		if facing_right:
			var bullet_inst = bullet_obj.instance()
			bullet_inst.dir="right"
			get_tree().get_root().add_child(bullet_inst)
			bullet_inst.global_position = global_position
			
		else:
			var bullet_inst = bullet_obj.instance()
			get_tree().get_root().get_node("Root").add_child(bullet_inst)
			bullet_inst.global_position = global_position
			
		time=0
		facing_right = !facing_right
		scale.x *= -1
	time+=1
	
	$AnimationPlayer.play("Idle")



func _on_Owl_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.take_damage(25)
