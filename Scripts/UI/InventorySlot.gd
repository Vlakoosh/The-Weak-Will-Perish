extends Control

export var basicType_icon : Texture
export var weaponType_icon : Texture
export var armorType_icon : Texture
export var accessoryType_icon : Texture


export(Globals.EquipmentType) var slot_type = Globals.EquipmentType.NONE setget on_slot_type_changed
export var index : int
export var title = "" setget on_title_changed

var item_reference : Object setget on_item_reference_changed
var quantity : int = 0 setget on_quantity_changed
var is_selected : bool = false setget on_selected_changed

func _ready():
    update_slot_type(slot_type)
    pass



func on_item_reference_changed(item_reference):
    if not item_reference:
        return
    $ItemIcon.texture = item_reference.icon

func on_title_changed(title):
    $Title.text = title

func on_quantity_changed(quantity):
    $Quantity.text = str(quantity) if quantity > 0 else ""

func on_selected_changed(is_selected):
    $Selection.visible = is_selected
    
func on_slot_type_changed(slot_type):
    update_slot_type(slot_type)
    
func update_slot_type(type):
    var new_icon : Texture
    match type :
        Globals.EquipmentType.NONE:
            new_icon = basicType_icon
        Globals.EquipmentType.WEAPON:
            new_icon = weaponType_icon
        Globals.EquipmentType.ARMOR:
            new_icon = armorType_icon
        Globals.EquipmentType.ACCESSORY:
            new_icon = accessoryType_icon
    $Icon.texture = new_icon
