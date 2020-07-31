extends Node2D

var current_background = 0
var ticks = 0
var backgrounds = ["res://sprites/backgrounds/Landscape 1.png", "res://sprites/backgrounds/Landscape 2.png",
	"res://sprites/backgrounds/Landscape 3.png", "res://sprites/backgrounds/Landscape4.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	ticks += 1
	if ticks == 1000:
		current_background += 1
		current_background = current_background%4
		ticks = 0
		$CanvasLayer/TextureRect.set_texture(load(backgrounds[current_background]))

func _on_NewGame_pressed():
	get_tree().change_scene("res://scenes/InitialCinematic1.tscn")

func _on_LoadGame_pressed():
	get_tree().change_scene("res://scenes/SavedGames.tscn")

func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
