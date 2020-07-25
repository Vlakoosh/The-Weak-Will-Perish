extends "res://Scripts/StateMachine.gd"

var JUMP_VALUE = 0

func _ready():
    add_state("idle")
    add_state("move")
    add_state("jump")
    add_state("fall")
    call_deferred("set_state",states.idle)
    
    
    parent.get_node("AnimationPlayer").connect("animation_finished",self,"_on_animation_finished")



# Virtual method, here goes everything that should execute in each different state
func _state_logic(delta):
    

    parent.motion.x=0
    if parent.x_input > 0:
        parent.x_direction = 1
    elif parent.x_input < 0:
        parent.x_direction = -1
        
    #M o v e m e n t, finally
    if parent.is_on_floor():
        if parent.x_input == 0:
            parent.motion.x = lerp(parent.motion.x, 0, parent.FRICTION * delta)
        else:
            if parent.x_input == 0:
                parent.motion.x = lerp(parent.motion.x, 0, parent.AIR_RESISTANCE * delta)
            
    #smooth motion
    parent.motion.x += parent.x_input * parent.ACCELERATION * delta * Globals.TARGET_FPS
    #Place a maximum on x movement
    parent.motion.x = clamp(parent.motion.x, -parent.MAX_SPEED, parent.MAX_SPEED)
    #Determine the direction c h a d should face
    parent.sprite.flip_h = parent.x_direction < 0
            
    if state == states.move:
        pass

    if state == states.idle:
        pass
    
    if state == states.jump:
        pass
    
    
    parent._apply_gravity(delta)
    parent._apply_movement(delta)
 
# Virtual method, rules for what state transitions into what state under what circunstances
func _get_transition(delta):
    
    match state:
        states.idle:
            if Input.is_action_just_pressed("move_up"):
                return states.jump
            if parent.motion.y > 0:
                return states.fall
                
            #Only allow the player to move when on the ground
            if parent.x_input != 0 and parent.is_on_floor():
                if parent.motion.y ==0:
                    return states.move
                    
        states.move:
            if parent.x_input == 0:
                return states.idle
            if Input.is_action_just_pressed("move_up"): 
                return states.jump
            if parent.motion.y > 0:
                return states.fall
                
        states.jump:
            if Input.is_action_just_pressed("move_up") and parent.jump_count+1 < parent.jumps_allowed:
                return states.jump
            if parent.motion.y > 0:
                return states.fall
            if parent.is_on_floor():
                return states.idle        
                
        states.fall:
            if Input.is_action_just_pressed("move_up") and parent.jump_count+1 < parent.jumps_allowed:
                return states.jump
            if parent.is_on_floor():
                return states.idle
        
    
# Virtual method, if you need something to execute when a certain state is entered
func _enter_state(new_state,old_state):
    #print("entered "+ str(new_state)+ " from " + str(old_state) )
    match state:
        states.idle:
            parent.animationPlayer.play("idle")
        states.move:
            parent.animationPlayer.play("run")
        states.jump:
            parent.jump_count += 1
            
            parent.motion.y =- parent.JUMP_FORCE
            parent.animationPlayer.play("jump")
            
            parent.inventory.add_item("RedFish",1)
          
        
        states.fall:
            parent.animationPlayer.play("fall")
            
# Virtual method, if you need something to execute when a certain state is exited
func _exit_state(old_state,new_state):
    match state:
        states.jump:
            pass

func _on_animation_finished( anim_name ):
    pass#print ("animation played: " +anim_name)
