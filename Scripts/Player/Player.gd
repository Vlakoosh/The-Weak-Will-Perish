extends KinematicBody2D

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

var inventory
var overlapping_areas = Array()

var interactables = Array()
var closest_interaction

func _ready():
    
    add_to_group("Player",1)
    
    var inventory_res = load("res://Scripts/Inventory.gd")
    inventory = inventory_res.new(3)
    inventory.set_slot_type(0,Globals.EquipmentType.WEAPON)
    inventory.set_slot_type(1,Globals.EquipmentType.ARMOR)
    inventory.set_slot_type(2,Globals.EquipmentType.ACCESSORY)
    
    #comment this out when not testing!
    #$Camera2D.set_zoom(Vector2(5, 5))
    #$Camera2D.current = true

func _physics_process(delta):
    
    if is_on_floor():
        jump_count = 0
        
    _handle_input()
    
func _process(delta):
    
    find_interactions()
    
    
    

func _handle_input():
    #Basic stuff for getting the l/r direction of a player. 
    x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
 
func _apply_gravity(delta):
    #Determine current up/down gravirt junk
    motion.y += Globals.GRAVITY * delta * Globals.TARGET_FPS
    
    
func find_interactions():
    
    $InteractionList.text = ""
    interactables.clear()
    for a in overlapping_areas:
        if a.get_parent().has_method("get_interaction_name"):
            interactables.append(a.get_parent())
        
    if interactables.size()>0:
        closest_interaction = interactables[0]
        for i in interactables:
            if self.position.distance_to(i.position)<self.position.distance_to(closest_interaction.position):
                closest_interaction=i
                
        $InteractionList.text = closest_interaction.get_interaction_name()
        
        
    
func _apply_movement(delta):
        
    motion = move_and_slide(motion, Vector2.UP)


func attack_animation_finished():
    pass

#added this, smooth transition too. You never notice it!
func _on_Next_Room_nextLevel():
    position.x += 16


func _on_InteractArea_area_entered(area):
    overlapping_areas.append(area)
    

func _on_InteractArea_area_exited(area):
    overlapping_areas.erase(area)
