extends KinematicBody2D

var TARGET_FPS = 60
var ACCELERATION = 80
#The fastest our chad can go
var MAX_SPEED = 100
var FRICTION = 20
var AIR_RESISTANCE = 0.75

#How high up you can jump
var JUMP_FORCE = 175

#Havent I seen this in ItemDB?
var jump_count = 0
var jumps_allowed = 2
#The motion of the player, duh
var motion = Vector2.ZERO
var x_input = 0
#Is the player being attacked?
var attacked = false
var x_direction = 1

#More efficient than calling $node every time you use it
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var attackAnimationPlayer = $AttackAnimationPlayer

#comment this out when not testing!
#func _ready():
    #$Camera2D.set_zoom(Vector2(5, 5))
    #$Camera2D.current = true

func _physics_process(delta):
    
    if is_on_floor():
        jump_count = 0
        
    _handle_input()
    
    
func _handle_input():
    #Basic stuff for getting the l/r direction of a player. 
    x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
 
func _apply_gravity(delta):
    #Determine current up/down gravirt junk
    motion.y += ItemDb.gravity * delta * TARGET_FPS
        
func _apply_movement(delta):
    #M o v e m e n t, finally
    
    if is_on_floor():
        if x_input == 0:
            motion.x = lerp(motion.x, 0, FRICTION * delta)
        else:
            if x_input == 0:
                motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
            
    #smooth motion
    motion.x += x_input * ACCELERATION * delta * TARGET_FPS
    #Place a maximum on x movement
    motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
    #Determine the direction c h a d should face
    sprite.flip_h = x_direction < 0
    
    motion = move_and_slide(motion, Vector2.UP)


func attack_animation_finished():
    pass

#added this, smooth transition too. You never notice it!
func _on_Next_Room_nextLevel():
    position.x += 16
