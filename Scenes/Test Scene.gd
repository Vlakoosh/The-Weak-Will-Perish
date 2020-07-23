#WE NEED MORE ROOMS FUCKERS
#I'M WORKING ON A WAY TO TURN COMPACT ENCODED IMAGES INTO ACTUAL LEVELS 

extends Node2D
#The current location of the next room
var location = Vector2()
#The scene variable is global to insure that all functions can access it
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
	#loop 52+ times to fill the array with levels

	for y in range(52):
		#I hate this
		var x = randi() % (ItemDb.preloaded_rooms.size()-3)
		#This too
		x+=3
		#This is much more efficient than IFs
		match y:
			#the first level is the beginning
			0:
				scene = ItemDb.preloaded_rooms[0].instance()
			#the last level is the end
			51:
				scene = ItemDb.preloaded_rooms[1].instance()
			#otherwise,
			_:
				scene = ItemDb.preloaded_rooms[2].instance() if (y%10==0 && y!=1) else ItemDb.preloaded_rooms[x].instance()
		#appends the given scene (see above) to the array
		sceneArray.append(scene)
	for y in range(52):
		nextLevel()

func nextLevel():
	#grab from the scene array and modify the global position to be equal to 'location' variable
	sceneArray[currentLevel].position = location
	#increase the x-value of the location variable
	location.x += 240
	#add the new room to the Level node
	Level.add_child(sceneArray[currentLevel])
	#index of the current level lol
	currentLevel+=1
	
		

func _on_Next_Room_nextLevel():
	#Move camera to next room
	$Camera2D.position.x+=240
	#Wait 1.5 seconds
	yield(get_tree().create_timer(1.5), "timeout")
	#delete the last room
	delete_children(Level)
	
static func delete_children(node):
    node.get_child(0).queue_free()
