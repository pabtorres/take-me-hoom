extends KinematicBody2D
var direction='left'

# Fricción
var hfriction = 60

var life=1000

# Restricciones de velocidad
var hspeed = 350 / 3.0
var vspeed = 600 / 3.0
var max_dspeed = 480 / 3.0
var gravity = 1000 / 3.0

# Para poder tacklear
var tackle = false
var tackle_friction = 120 / 3.0

# Para esperar animación de dormir
var sleep_animation = false

# Para teletransportarse
var teleport = false

# Para poder lanzar proyectiles
var bullet = true
var bullet_cooldown = 0.25
var bullet_cooldown_counter = 0

# Para poder dormir tiene que tener en True el boolean
var can_sleep = false

# Power-ups - EXPERIMENTAL
#var double_jump = false
var recently_jumped = false

var isBig= true
var isSmall=false

# Chequear caida libre
var level_just_started = true
var start_fall_clock = false
var fall_start

# Checkpoints
#var level_spawn_position

# Timer for enemy creation when hero
var timer=0
const bullet_obj = preload("res://scenes/Enemy.tscn")

# Referencia gravedad
export var velocity = Vector2.ZERO
# Animation player of protagonist
onready var anim_player = $AnimationPlayer

# right = 1 / left = -1
var facing = -1

# Método creado para multiplicar por -1
func reverse(val):
	return -val

func _ready():
	# Keys invisible
	$Key_D.visible = false
	# Get life points
	update_progress_bar(LevelManager.life_points)
	# When player is instanciated, it is not in dark mode
	
	LevelManager.dark_zone = false
	if LevelManager.player_position_day and !LevelManager.is_player_sleeping:
		position = LevelManager.player_position_day
		
		
	if LevelManager.player_position_night and LevelManager.is_player_sleeping:
		position = LevelManager.player_position_night
	anim_player.connect("animation_finished", self, "on_animation_finished")
	#level_spawn_position = LevelManager.level_spawn_position()
	
func on_animation_finished(anim_name: String):
	if anim_name == "Sleep":
		if LevelManager.is_player_sleeping == true:
			LevelManager.turn_to_night()
		else:
			LevelManager.turn_to_day()
	if anim_name == "Death":
		print("Te moriste :'(")
	
func _physics_process(delta):
	
	# Gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, true)
	
	var on_floor = is_on_floor()
	if LevelManager.is_player_sleeping:
		timer+=delta
	
	if on_floor:
		if Input.is_action_just_pressed("jump1"):
			velocity.y = -vspeed
			recently_jumped = true # To test double_jump
		
		if Input.is_action_just_pressed("small") && isBig && Global.player_powerups["Small"]:
			self.set_scale(Vector2(0.5, -0.5))
			if facing==-1:
				self.set_scale(Vector2(0.5,0.5))
			isSmall=true
			isBig=false
		
		if Input.is_action_just_pressed("big") && isSmall && Global.player_powerups["Small"]:
			self.set_scale(Vector2(1, -1))
			if facing==-1:
				self.set_scale(Vector2(1,1))
			isBig=true
			isSmall=false
		
		if Input.is_action_just_pressed("sleep") and !LevelManager.is_player_sleeping and can_sleep:
			LevelManager.is_player_sleeping = true
			anim_player.play("Sleep")
			LevelManager.player_position_day = self.position
			LevelManager.enemy_must_be_instantiated=false
			set_physics_process(false)
			return
		
	
		if Input.is_action_just_pressed("awake") and LevelManager.is_player_sleeping:
			LevelManager.is_player_sleeping = false
			anim_player.play("Sleep")
			if timer>10:
				LevelManager.enemy_must_be_instantiated=true
			LevelManager.player_position_night = self.position
			set_physics_process(false)
			return
		
		if Input.is_action_just_pressed("attack1"):
			pass
			
		# Acción para activar shader
		if Input.is_action_just_pressed("dark_place"):
			LevelManager.dark_zone = true
		
	var target_vel = (Input.get_action_strength("right1") - Input.get_action_strength("left1")) * hspeed
	velocity.x = lerp(velocity.x, target_vel, 0.25)
	
	# Stop if barking
	if on_floor:
		if Input.is_action_just_pressed("attack1") or anim_player.current_animation == "Bark":
			velocity.x = 0
	
	if target_vel != 0:
		var new_facing = sign(target_vel)
		if facing != new_facing:
			scale.x = scale.x*(-1)
			facing = new_facing

		

	# Animation
	
	anim_player.playback_speed = 1
	
	if on_floor:
		if Input.is_action_just_pressed("attack1"):
			anim_player.play("Bark")
		if anim_player.current_animation != "Bark":
			if abs(velocity.x) > 10.0:
				anim_player.play("Run")
				anim_player.playback_speed = 2 * abs(velocity.x)/hspeed
			else:
				anim_player.play("Idle")
	else:
		if Input.is_action_just_pressed("attack1"):
			anim_player.play("OnAirBark")
		if anim_player.current_animation != "OnAirBark":
			anim_player.play("Jump")
	
	if on_floor:
		if level_just_started:
			level_just_started = false
		start_fall_clock = true
	
	# Testing double_jump power-up and free falling timeout
	if not on_floor:
		if Input.is_action_just_pressed("jump1") and Global.player_powerups["DoubleJump"] and recently_jumped:
			velocity.y = -vspeed
			recently_jumped = false
		if velocity.y > 0 and not level_just_started:
			if start_fall_clock:
				fall_start = OS.get_unix_time()
				start_fall_clock = false
			else:
				if OS.get_unix_time() - fall_start > 3:
					fall_start = -1
					level_just_started = true
					start_fall_clock = false
					self.position = LevelManager.level_spawn_position() #current checkpoint
					#update_progress_bar(LevelManager.get_max_life_points())
					#LevelManager.reset_life_points()
		if velocity.y < 0:
			start_fall_clock = true

func take_damage():
	LevelManager.life_points-=25
	update_progress_bar(LevelManager.life_points)
	if LevelManager.life_points <= 0:
		anim_player.play("Death")
		set_physics_process(false)


func _on_Attack_body_entered(body: Node):
	if body.is_in_group("Enemy"):
		body.take_damage()


func _on_Attack_area_entered(area):
	if area.is_in_group("Enemy"):
		area.take_damage()
		
func set_can_sleep(state: bool):
	can_sleep = state
	
func set_sleep_key(state: bool):
	$Key_D.visible = state

func set_spawn_position(position: Vector2):
	LevelManager.override_spawn_position(position)

func update_progress_bar(number: int):
	$CanvasLayer/ProgressBar.value = number
