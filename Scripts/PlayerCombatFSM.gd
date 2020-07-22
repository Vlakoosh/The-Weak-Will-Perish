extends "res://Scripts/StateMachine.gd"



func _ready():
    add_state("idle")
    #add_state("move")
    add_state("attack")
    call_deferred("set_state",states.idle)

# Virtual method, here goes everything that should execute in each different state
func _state_logic(delta):
    if state == states.idle:
        pass
    
    
    if state == states.attack:
        
        parent.motion.x = lerp(parent.motion.x, 0, parent.FRICTION*0.5 * delta)
        
        

# Virtual method, rules for what state transitions into what state under what circunstances
func _get_transition(delta):
    
    match state:
        states.idle:
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
            set_state(states.idle)
        
# Virtual method, if you need something to execute when a certain state is exited
func _exit_state(old_state,new_state):
    pass


