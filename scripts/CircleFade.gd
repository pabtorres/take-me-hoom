# For visualizing in the editor
#tool

extends Node2D

export(NodePath) var target
export(NodePath) var player

onready var shader = $CanvasLayer/ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	shader.material.set("shader_param/radius", 2)
	shader.material.set("shader_param/amount", 0)
	print("hello")
	print(self)



func _process(delta):
	if(LevelManager.dark_zone):
		#get_node(player).get_node("Area2D/CollisionShape2D").shape.radius += (-Input.get_action_strength("ui_home") + Input.get_action_strength("ui_end"))
		var amount_before = shader.material.get("shader_param/amount")
		var radius_before = shader.material.get("shader_param/radius")
		var amount_after = lerp(amount_before, 1, 0.005)
		var radius_after = lerp(radius_before, 0.09, 0.005)
		shader.material.set("shader_param/radius", radius_after)
		shader.material.set("shader_param/amount", amount_after)
