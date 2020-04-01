extends Node

var time_start = 0
var time_now = 0
var control_node = null

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	if seconds > 15:
		time_start = OS.get_unix_time()
		time_now = 0
		print("hola")
		for node in control_node.get_children():
			print(node)
			# Se puede evitar instance of con ejecutar un método
			# que no haga nada
			node.shade()
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	# print("elapsed : ", str_elapsed)
