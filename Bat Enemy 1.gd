extends KinematicBody2D

var velocity = Vector2()

var max_speed = 100
var acceleration = 50
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone

func _physics_process(delta):
    var player = playerDetectionZone.player
    var direction = player.global_position - global_position.normalized()
    if player != null:
        velocity = velocity.move_toward(direction*max_speed,acceleration*delta)
    
    velocity = move_and_slide(velocity)
