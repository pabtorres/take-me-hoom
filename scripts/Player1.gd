extends KinematicBody2D
var direction='left'

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

# Para esperar animación de dormir
var sleep_animation = false

# Para teletransportarse
var teleport = false

# Para poder lanzar proyectiles
var bullet = true
var bullet_cooldown = 0.25
var bullet_cooldown_counter = 0

# Referencia gravedad
export var gravity = 0
export var velocity = Vector2.ZERO
# Animation player of protagonist
onready var anim_player = get_node("AnimationPlayer")

# Método creado para multiplicar por -1
func reverse(val):
	return -val

func set_attack(value: bool):
	$Attack.disabled=!value
	$Attack/Sprite.visible=not $Attack/Sprite.visible
	
	
func _ready():
	if LevelManager.player_position_day != null and !LevelManager.is_player_sleeping:
		self.position = LevelManager.player_position_day
	
func _physics_process(delta):

	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP, true)
	
	if !sleep_animation:
	
		var hsign = sign(velocity.x)
		velocity.x -= hsign * hfriction
		if sign(velocity.x) != hsign:
			velocity.x = 0
			
		if Input.is_action_pressed("sleep") and !LevelManager.is_player_sleeping:
			LevelManager.is_player_sleeping = true
			MusicManager.can_change_music = true
			sleep_animation = true
			$AnimationPlayer.play("Sleep")
			LevelManager.player_position_day = self.position
			
		
		if Input.is_action_just_pressed("awake") and LevelManager.is_player_sleeping:
			LevelManager.is_player_sleeping = false
			MusicManager.can_change_music = true
			sleep_animation = true
			$AnimationPlayer.play("Sleep")
			
		if Input.is_action_pressed("jump1") && gravity == 0:
			velocity.y = -max_uspeed
			gravity = max_gravity
			$AnimationPlayer.play("Jump")
		
		# Permite realizar ataque mientras se está en el aire
		if Input.is_action_pressed("attack1") && gravity != 0:
			$AnimationPlayer.play("OnAirBark")
			
		# Se añade una consulta para saber si se está activada la animación de ladrido
		if Input.is_action_pressed("left1") && !Input.is_action_pressed("right1") && $AnimationPlayer.current_animation != "Bark" && $AnimationPlayer.current_animation != "OnAirBark":
			velocity.x = -max_hspeed
			if direction=="right":
				$Attack/Sprite.position.x-=20
				$Attack.position.x *=-1
				$Attack/Sprite.flip_h=false
				direction="left"
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( false )
			
		
				
		# Se añade una consulta para saber si se está activada la animación de ladrido
		if Input.is_action_pressed("right1") && !Input.is_action_pressed("left1") && $AnimationPlayer.current_animation != "Bark" && $AnimationPlayer.current_animation != "OnAirBark":
			velocity.x = max_hspeed
			if direction=="left":
				$Attack.position.x *=-1
				$Attack/Sprite.flip_h=true
				$Attack/Sprite.position.x+=20
				direction="right"
			$AnimationPlayer.play("Run")
			get_node( "Sprite" ).set_flip_h( true )
			
		# Acción para activar shader
		if Input.is_action_just_pressed("dark_place"):
			LevelManager.dark_zone = true
	
			
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
		
	else: #Sleep animation is active
		teleport = true
		if $AnimationPlayer.current_animation != "Sleep":
			sleep_animation = false
			if LevelManager.is_player_sleeping == true:
				LevelManager.turn_to_night()
			else:
				LevelManager.turn_to_day()
		
