extends Resource
class_name Inventory

signal inventory_changed

export var _item_slots = Array() setget set_item_slots,get_item_slots
var max_slots : int = 256


func _init( slots ):
    max_slots = slots
    
    for i in range(max_slots):
        var new_item = {
            item_reference = null,
            quantity = 0,
            slot_type = Globals.EquipmentType.NONE
        }
        _item_slots.append(new_item)
    emit_signal("inventory_changed",self)
        
func set_slot_type(index, type):
    _item_slots[index].slot_type = type
    emit_signal("inventory_changed",self)

func set_item_slots(new_item_slots):
    _item_slots = new_item_slots
    emit_signal("inventory_changed",self)
    
func get_item_slots():
    return _item_slots
    
func get_item(index):
    return _item_slots[index]
    
func add_item(id , quantity):
    if quantity <= 0:
        print("Warning: Tried to add item with quantity <= 0: "+str(quantity))
        return
    
    var item = ItemDb.get_item(id)
    if not item:
        print("Warning: Tried to add item with unexistent id:"+str(id))
        return
    
    var remaining_quantity = quantity
    var max_stack_size = item.max_stack_size if item.stackable else 1
        
    if item.stackable:
        # Loop through every slot in the inventory and find avaiable slots
        # for stackable items
        for i in range(_item_slots.size()):

            if remaining_quantity == 0:
                break
            
            var inventory_item = _item_slots[i]
            # If item in current inv slot is not the one we are trying to add, skip slot
            if inventory_item.item_reference:
                if inventory_item.item_reference.name != item.name:
                    continue
                    
            # Slot is only usable if it's no particular type, or same type as item
            if inventory_item.slot_type != Globals.EquipmentType.NONE and inventory_item.slot_type != item.equip_type:
                continue
                
            # If it's the item we are trying to add, and it's not already full
            if inventory_item.quantity < max_stack_size:
                
                # Add as many of the item we can to the slot
                var original_quantity = inventory_item.quantity
                inventory_item.item_reference = item
                inventory_item.quantity = min(original_quantity+remaining_quantity, max_stack_size)
                remaining_quantity -= inventory_item.quantity-original_quantity
    else:
        # Loop through every slot in the inventory and find avaiable slots
        # for non-stackable items
        for i in range(_item_slots.size()):

            var inventory_item = _item_slots[i]
            if remaining_quantity == 0:
                break
            if inventory_item.quantity > 0:
                continue
                
            # Slot is only usable if it's no particular type, or same type as item
            if inventory_item.slot_type != Globals.EquipmentType.NONE and inventory_item.slot_type != item.equip_type:
                continue
                
            inventory_item.item_reference = item
            inventory_item.quantity = quantity
            remaining_quantity -= 1
                
        pass

    
    emit_signal("inventory_changed",self)
    #print("Added item: " + id + " x"+str(quantity-remaining_quantity)) if quantity-remaining_quantity > 0 else null
    #print("Inventory Full!") if remaining_quantity > 0 else null

    return remaining_quantity

##IDK what ItemDB is -Cold
#var item_base = preload("res://Scenes/ItemDB.tscn")
##What?
#onready var inv_base = $InventoryBase
#onready var equipment_slots = $EquipmentSlots
##Ok you'll need to walk me through this -Cold
#var item_held
#var item_offset = Vector2()
#var last_container = null
#var last_pos = Vector2()
