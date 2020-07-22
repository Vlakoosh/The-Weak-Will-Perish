extends Control

#IDK what ItemDB is -Cold
var item_base = preload("res://Scenes/ItemDB.tscn")
#What?
onready var inv_base = $InventoryBase
onready var equipment_slots = $EquipmentSlots
#Ok you'll need to walk me through this -Cold
var item_held
var item_offset = Vector2()
var last_container = null
var last_pos = Vector2()
