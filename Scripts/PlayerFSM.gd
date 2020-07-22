extends "res://Scripts/StateMachine.gd"



func _ready():
    add_state("idle")
    add_state("move")
    add_state("attack")
    call_deferred("set_state",states.move)

# Virtual method, here goes everything that should execute in each different state
func _state_logic(delta):
    
    
    if state == states.move:
        #parent._move(delta)
        if parent.x_input > 0:
            parent.x_direction = 1
        elif parent.x_input < 0:
            parent.x_direction = -1


        #determines the players current animations based on motion
        if parent.motion.y > 0:
            parent.animationPlayer.play("fall")
        if parent.motion.y < 0:
            parent.animationPlayer.play("jump")
        if parent.x_input != 0:
            if parent.motion.y ==0:
                parent.animationPlayer.play("run")
            #smooth motion
            parent.motion.x += parent.x_input * parent.ACCELERATION * delta * parent.TARGET_FPS
            #Place a maximum on x movement
            parent.motion.x = clamp(parent.motion.x, -parent.MAX_SPEED, parent.MAX_SPEED)
            #Determine the direction c h a d should face
            parent.sprite.flip_h = parent.x_input < 0
        else:
            if parent.motion.y == 0:
                parent.animationPlayer.play("idle")
        #Only allow the player to move when on the ground
        if parent.is_on_floor():
            parent.jump_count = 0
            if parent.x_input == 0:
                #Teach me about "lerp" later koosh
                parent.motion.x = lerp(parent.motion.x, 0, parent.FRICTION * delta)
                
        else:
            
            if parent.x_input == 0:
                parent.motion.x = lerp(parent.motion.x, 0, parent.AIR_RESISTANCE * delta)
        #Determine how much you've jumped and jump based on that
        if Input.is_action_just_pressed("move_up") and parent.jump_count < parent.jumps_allowed:
            parent.jump_count += 1
            parent.motion.y = -parent.JUMP_FORCE
    
    if state == states.attack:
        
        parent.motion.x = lerp(parent.motion.x, 0, parent.FRICTION*0.5 * delta)
        
        
    
    parent._gravity_and_movement(delta)
 
# Virtual method, rules for what state transitions into what state under what circunstances
func _get_transition(delta):
    
    match state:
        states.move:
            if Input.is_action_just_pressed("ui_up"):
                return states.attack
    
        states.attack:
            pass
    
# Virtual method, if you need something to execute when a certain state is entered
func _enter_state(new_state,old_state):
    
    match state:
        states.attack:
            var animation
            #If you aren't falling...
            if parent.motion.y > 0:
                #?
                #determining attack direction
                if parent.x_direction > 0:
                    animation = "attack_down_right"
                if parent.x_direction < 0:
                    animation = "attack_down_left"
            #fixed ye code, bud
            if parent.motion.y == 0 or parent.motion.y < 0:
    
                if parent.x_direction > 0:
                    animation = "attack_idle_right"
                if parent.x_direction < 0:
                    animation = "attack_idle_left"
            
            parent.animationPlayer.play(animation)
            yield(parent.animationPlayer,"animation_finished")
            set_state(states.move)
        
# Virtual method, if you need something to execute when a certain state is exited
func _exit_state(old_state,new_state):
    pass


