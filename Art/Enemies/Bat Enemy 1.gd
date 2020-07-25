extends KinematicBody2D

onready var stats = $Stats
#By doing this it doesn't have to grab the node every time the Visibility Notifier is used
onready var VisNotif = $VisibilityNotifier2D
#The speed of the bat, obviously
export var speed = 50
#Fixed icky get_parent().get_parent().get_parent()...This ain't a family tree
onready var obj = GameManager.player

func _physics_process(delta):
    if not obj or not VisNotif.is_on_screen():
        obj = GameManager.player
        return
    
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
    if area.name=="Hitbox":
        stats.health =- ItemDb.player_damage
