extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var DebugText = $DebugText

# Called when the node enters the scene tree for the first time.
func _ready():

    
    DebugText.add_font_override("font",load("res://Fonts/PIXELITE.tres"))


    pass


