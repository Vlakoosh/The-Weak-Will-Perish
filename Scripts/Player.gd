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
var x_input = 0
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
    
    _handle_input()
    
    
func _handle_input():
    #Basic stuff for getting the l/r direction of a player. 
    x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    #fixed a bug allowing the player to attck backwards if they slid off collision
    
        
func _gravity_and_movement(delta):
        
    #Determine current up/down gravirt junk
    motion.y += ItemDb.gravity * delta * TARGET_FPS
    #M o v e m e n t, finally
    motion = move_and_slide(motion, Vector2.UP)


    

#added this, smooth transition too. You never notice it!
func _on_Next_Room_nextLevel():
    position.x += 16
