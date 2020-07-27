extends Node2D
class_name ItemDrop

export var itemId : String = ""

var item : Resource setget on_item_changed
var quantity : int = 1

func _ready():
    
    item = ItemDb.get_item(itemId)
    if item and itemId != "":
        $Name.text = item.name
        $Sprite.texture = item.icon


func _on_Area2D_body_entered(body):
    return
    if body.name == "Player":
        $Name.visible=true
        print(body.get_groups())

func on_item_changed(i):
    pass


func _on_Area2D_body_exited(body):
    return
    if body.name == "Player":
        $Name.visible=false
    pass # Replace with function body.
    
func get_interaction_name():
    return item.name

