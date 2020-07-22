extends Node2D
#honestly idk
var location = Vector2()
#scene is global
var scene
#Much, Much more efficient
onready var Level = $Level
#An array of scenes, loaded on startup to reduce scene-to-scene load time
var sceneArray = []
#Keeps track of the current index of the array
var currentLevel = 0

func _ready():
    #Make a new seed
    randomize()
    #loop 50 times to fill the array with levels

    for _y in range(50):
        var x = randi() % ItemDb.preloaded_rooms.size()
        scene = ItemDb.preloaded_rooms[x].instance()
        sceneArray.append(scene)
        nextLevel()

func nextLevel():
    sceneArray[currentLevel].position = location
    location.x += 240
    Level.add_child(sceneArray[currentLevel])
    #print(currentLevel+1)
    currentLevel+=1

func _on_Next_Room_nextLevel():
    $Camera2D.position.x+=240
    yield(get_tree().create_timer(1.5), "timeout")
    delete_children(Level)
    
static func delete_children(node):
    node.get_child(0).queue_free()
