extends Node2D


var speed = -0.75
var ending_credits
var greetings
var ending_button
var move_text = true

# Called when the node enters the scene tree for the first time.
func _ready():
	ending_credits = get_tree().get_nodes_in_group("EndingCredits")[0]
	greetings = get_tree().get_nodes_in_group("Greeting")[0]
	ending_button = get_tree().get_nodes_in_group("EndButton")[0]


func _physics_process(delta):
	if move_text:
		var move = Vector2()
		move.y = speed
		ending_credits.set_position(ending_credits.get_position() + move)
		if greetings.get_global_position().y <= 90:
			speed = 0
			move_text = false
			ending_button.show()


func _on_Ending_pressed():
	LevelManager.exit_to_menu()
