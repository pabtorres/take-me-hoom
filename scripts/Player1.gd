extends KinematicBody2D

# Fricción
var hfriction = 60

# Restricciones de velocidad
var max_hspeed = 350
var max_uspeed = 600
var max_dspeed = 480
var max_gravity = 1000

# Para poder tacklear
var tackle = false
var tackle_friction = 120

# Para poder lanzar proyectiles
var bullet = true
var bullet_cooldown = 0.25
var bullet_cooldown_counter = 0

# Referencia gravedad
export var gravity = 0
export var velocity = Vector2.ZERO

# Método creado para multiplicar por -1
func reverse(val):
	return -val
	
func _ready():
	print("holaready")
	Globals.control_node = get_tree().get_root().get_node("parent")
	
func shade():
	pass

func _physics_process(delta):

	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP, true)
	
	if !tackle:
	
		var hsign = sign(velocity.x)
		velocity.x -= hsign * hfriction
		if sign(velocity.x) != hsign:
			velocity.x = 0
			
		if Input.is_action_pressed("jump1") && gravity == 0:
			velocity.y = -max_uspeed
			gravity = max_gravity
			$AnimationPlayer.play("Jump")
			for node in get_children():
				print(node)
			
		# Se añade una consulta para saber si se está activada la animación de ladrido
		if Input.is_action_pressed("left1") && !Input.is_action_pressed("right1") && $AnimationPlayer.current_animation != "Bark":
			velocity.x = -max_hspeed
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( false )
			
		
				
		# Se añade una consulta para saber si se está activada la animación de ladrido
		if Input.is_action_pressed("right1") && !Input.is_action_pressed("left1") && $AnimationPlayer.current_animation != "Bark":
			velocity.x = max_hspeed
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( true )
			
		
	
			
		if is_on_floor() && velocity.y > 0 && abs(velocity.x) == 0 :
			# Se añade una consulta para saber si se está activada la animación de ladrido
			# Si no está activada esa animación, entonces puede pasar a animar idle
			if !Input.is_action_pressed("attack1") && $AnimationPlayer.current_animation != "Bark":
				$AnimationPlayer.play("Idle")
			else: 
				$AnimationPlayer.play("Bark")
			
			
			
			
			
			gravity = 0
			velocity.y = 0
		else:
			gravity = max_gravity
	
		velocity.y = min(velocity.y, max_dspeed)
		
