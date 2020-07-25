extends Node2D
#Get the Tile map of the level
onready var Level = $TileMap

#Load my test level.png. This will change to getting the preloaded array.
#getting data is so we don't just have a sprite in memory
onready var image = load("res://level.png").get_data()
#gets the height/width of the image (Vector2
onready var size = image.get_size()
#This is an array to for getting each pixel
onready var imagearr = []
#This is an array for each pixel in imagearr. Used for iterating over the entire level
onready var levelarr = []

#We'll eventually need to load every enemy here :/
var batEnemy = preload("res://Art/Enemies/Bat Enemy 1.tscn")

func _ready():
	#images can't be read without being locked
	image.lock()
	#Iteraties over the whole array. You get the idea, will not be commenting a *FUCKIN* for loop after this 
	for x in range(size.x):
		#makes imagearr 2D, and adds one pixel in the second dmimension per loop
		imagearr.append([])
		for y in range(size.y):
			#appends the current color in the image on the image array. formatted ass rgba32 because you can make a Color() from rgba32
			imagearr[x].append(image.get_pixel(x,y).to_rgba32())
	for x in range(imagearr.size()):
		#do the same as the last loop
		levelarr.append([])
		for y in range(imagearr[x].size()):
			#appends Color(x,y) to levelarr
			levelarr[x].append(Color(imagearr[x][y]))
	for fuck in range(size.x):
		#need a ceiling and floor
		Level.set_cell(fuck, -1, 0)
		Level.set_cell(fuck, 10, 0)
	for x in range(size.x):
		for y in range(size.y):
			#fixes background bug
			Level.set_cell(x,y,1)
			#special conditions
			if levelarr[x][y].r == 0 && levelarr[x][y].g == 0 && levelarr[x][y].b == 0:
				#sets a level based on the alpha (if a>0.5 its a wall, if it's <0.5 it's a wall)
				Level.set_cell(x, y, !round(levelarr[x][y].a))
			#sets bats when there's a red tile with a reasonable alpha (a>0 fixed a bug)
			if levelarr[x][y].r == 1 && levelarr[x][y].g == 0 && levelarr[x][y].b == 0 && levelarr[x][y].a > 0 :
				#instance a bat
				var newBat = batEnemy.instance()
				#set it's position
				newBat.position = Vector2(Level.map_to_world(Vector2(x,y))) + Vector2(8,8)
				#determine the mode, Idle or OnScreen
				newBat.mode= !levelarr[x][y].a < 1
				#add to room
				add_child(newBat)
	#update the autotiles to work as *autotiles*
	Level.update_bitmask_region(Vector2(), OS.window_size)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
