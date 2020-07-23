extends KinematicBody2D

var TARGET_FPS = 60
var ACCELERATION = 80
#The fastest our chad can go
var MAX_SPEED = 100
var FRICTION = 20
var AIR_RESISTANCE = 0.75

#The force used in a jump?
var JUMP_FORCE = 175
#Havent I seen this in ItemDB?
var jump_count = 0
var jumps_allowed = 2
#The current state of the player
var state = "move"
#The motion of the player, duh
var motion = Vector2.ZERO
#Is the player being attacked?
var attacked = false
var x_direction = 1

#More efficient than calling $node every time you use it
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

#comment this out when not testing!
#func _ready():
    #$Camera2D.set_zoom(Vector2(5, 5))
    #$Camera2D.current = true

func _physics_process(delta):
    #Basic stuff for getting the l/r direction of a player. 
    var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    #fixed a bug allowing the player to attck backwards if they slid off collision
    if state == "move":
        attacked = false
        if x_input > 0:
            x_direction = 1
        elif x_input < 0:
            x_direction = -1
        #attack!
        if Input.is_action_just_pressed("ui_up"):
            state = "attack"
        #determines the players current animations based on motion
        if motion.y > 0:
            animationPlayer.play("fall")
        if motion.y < 0:
            animationPlayer.play("jump")
        if x_input != 0:
            if motion.y ==0:
                animationPlayer.play("run")
            #smooth motion
            motion.x += x_input * ACCELERATION * delta * TARGET_FPS
            #Place a maximum on x movement
            motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
            #Determine the direction c h a d should face
            sprite.flip_h = x_input < 0
        else:
            if motion.y == 0:
                animationPlayer.play("idle")
        #Only allow the player to move when on the ground
        if is_on_floor():
            ItemDb.jump_count = 0
            if x_input == 0:
                #Teach me about "lerp" later koosh
                motion.x = lerp(motion.x, 0, FRICTION * delta)
                
            
        else:
            
            if x_input == 0:
                motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
        #Determine how much you've jumped and jump based on that
        if Input.is_action_just_pressed("move_up") and ItemDb.jump_count < ItemDb.jumps_allowed:
            ItemDb.jump_count += 1
            motion.y = -JUMP_FORCE
    #If you are attacking...
    if state == "attack":
        #if you aren't being attacked...
        if attacked == false:
            #If you aren't falling...
            if motion.y > 0:
                #?
                attacked = true
                #determining attack direction
                if x_direction > 0:
                    animationPlayer.play("attack_down_right")
                    
                if x_direction < 0:
                    animationPlayer.play("attack_down_left")
            #fixed ye code, bud
            if motion.y == 0 or motion.y < 0:
                attacked = true
                if x_direction > 0:
                    animationPlayer.play("attack_idle_right")

                if x_direction < 0:
                    animationPlayer.play("attack_idle_left")
        
        motion.x = lerp(motion.x, 0, FRICTION*0.5 * delta)
    #Determine current up/down gravirt junk
    motion.y += ItemDb.gravity * delta * TARGET_FPS
    #M o v e m e n t, finally
    motion = move_and_slide(motion, Vector2.UP)

func attack_animation_finished():
    state = "move"
    

#added this, smooth transition too. You never notice it!
func _on_Next_Room_nextLevel():
    position.x += 16
