extends Resource
class_name Inventory

signal inventory_changed

export var _items = Array() setget set_items,get_items
var max_slots : int = 256


func set_max_slots(slots):
    max_slots = slots

func set_items(new_items):
    _items = new_items
    emit_signal("inventory_changed",self)
    
func get_items():
    return _items
    
func get_item(index):
    return _items[index]
    
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
        # Loop through every slot in the inventory
        for i in range(_items.size()):

            if remaining_quantity == 0:
                break
            
            var inventory_item = _items[i]
            # If item in current inv slot is not the one we are trying to add, skip slot
            if inventory_item.item_reference.name != item.name:
                continue
                
            # If it's the item we are trying to add, and it's not already full
            if inventory_item.quantity < max_stack_size:
                
                # Add as many of the item we can to the slot
                var original_quantity = inventory_item.quantity
                inventory_item.quantity = min(original_quantity+remaining_quantity, max_stack_size)
                remaining_quantity -= inventory_item.quantity-original_quantity
                
                
    while remaining_quantity > 0 and _items.size() < max_slots :
        var new_item = {
            item_reference = item,
            quantity = min(remaining_quantity, max_stack_size)
        }
        _items.append(new_item)
        remaining_quantity -= new_item.quantity
        
    
    emit_signal("inventory_changed",self)
    print("Added item: " + id + " x"+str(quantity-remaining_quantity)) if quantity-remaining_quantity > 0 else null
    print("Inventory Full!") if remaining_quantity > 0 else null

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
