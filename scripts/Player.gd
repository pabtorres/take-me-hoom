extends KinematicBody2D

# Fricción
var hfriction = 60

# Restricciones de velocidad
var max_hspeed = 240
var max_uspeed = 600
var max_dspeed = 480
var max_gravity = 1800

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

func _physics_process(delta):

	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP, true)
	
	if !tackle:
	
		var hsign = sign(velocity.x)
		velocity.x -= hsign * hfriction
		if sign(velocity.x) != hsign:
			velocity.x = 0
			
		if Input.is_action_pressed("jump") && gravity == 0:
			velocity.y = -max_uspeed
			gravity = max_gravity
		
		if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
			velocity.x = -max_hspeed
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( false )
			
		if Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
			velocity.x = max_hspeed
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( true )
			
		if Input.is_action_pressed("teleport"):
			Globals.player_position_day = self.position
			
		if Input.is_action_pressed("ateleport"):
			self.position.x = Globals.player_position_day.x
			self.position.y = Globals.player_position_day.y
			
		if is_on_floor() && velocity.y > 0 && abs(velocity.x) == 0:
			$AnimationPlayer.play("Idle")
			gravity = 0
			velocity.y = 0
		else:
			gravity = max_gravity
	
		velocity.y = min(velocity.y, max_dspeed)
		
