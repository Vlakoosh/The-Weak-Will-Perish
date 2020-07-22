extends KinematicBody2D

#god WHY
onready var stats = $Stats
#By doing this it doesn't have to grab the node every time the Visibility Notifier is used
onready var VisNotif = $VisibilityNotifier2D
#The speed of the bat, obviously
var speed = 50
#Getting the player, pretty uncleanly too :p
onready var obj = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(delta):
    #Point towards the player
    var dir = (obj.global_position - global_position).normalized()
    #Only move when on screen
    if VisNotif.is_on_screen():
        move_and_collide(dir * speed * delta)
    #Die
    if stats.health <= 0:
        queue_free()
        

#Koosh why
func _on_HurtBox_area_entered(area):
    #queue_free()
    
    stats.health - ItemDb.player_damage
