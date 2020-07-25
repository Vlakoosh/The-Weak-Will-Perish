extends Node

signal player_initialized

var player

func _process(delta):
    var a =get_tree().get_root()
    
    if not player:
        initialize_player()
        return
    
func initialize_player():
    player = get_tree().get_root().get_node("Test Scene/Player")
    if not player:
        return
        
    emit_signal("player_initialized",player)

