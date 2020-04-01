extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var alive
var lifePoints
export var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	alive=true;
	lifePoints=50;
	print(lifePoints)
	#move_and_slide(velocity, Vector2.UP, true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Enemy_area_entered(area):
	pass
	
func shade():
	modulate = Color(0,0,0)


func _on_Enemy_body_entered(body):
	if alive:
		lifePoints-=10;
	if lifePoints<=0:
		alive=false
		
	print(lifePoints)
	print(alive)
	print(body)
