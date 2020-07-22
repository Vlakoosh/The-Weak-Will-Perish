extends Node
#Max player health
var MAX_HEALTH = 1
#Current player health
var player_health = 1
var gravity = 15
#The amount the player has jumped
var jump_count = 0
#Maximum jumps
var jumps_allowed = 2
#Damage the player can deal
var player_damage = 1

signal nextLevel
#Rooms loaded. Eventually will contain every level I guess?
var preloaded_rooms = [
    preload("res://Rooms/Room1.tscn"),
    preload("res://Rooms/Room2.tscn"),
    preload("res://Rooms/Room3.tscn")
]



#The path to the items
const ICON_PATH = "res://Art/Items"
#Items
const ITEMS = {
    "StickSword": {
        "icon": ICON_PATH + "StickSword.png",
        "type": "SWORD"
    },
    "DirtyLeatherShirt": {
        "icon": ICON_PATH + "DirtyLeatherShirt.png",
        "type": "ARMOR"
    },
    "RedFish": {
        "icon": ICON_PATH + "RedFish.png",
        "type": "SWORD"
    },
    "Greatsword": {
        "icon": ICON_PATH + "Greatsword.png",
        "type": "SWORD"
    }
}
#Pretty smart! Nice one, Koosh!

func get_item(item_id):
    #If the item exists in the item dict
    if item_id in ITEMS:
        #return it
        return ITEMS[item_id]
    #else,
    else:
        #Error.
        return ITEMS["error"] #Wait does that even work? there is no error item.

#lazy fuck
func _on_Next_Room_nextLevel():
    pass # Replace with function body.
