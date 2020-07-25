extends Control


var _slots = Array()
var player
var selected_slot = 1

func _ready():
    for c in $HBoxContainer.get_children():
        _slots.append( c )
    update_selected(1)
    
func _process(delta):
    if not player:
        player = GameManager.player
        player.inventory.connect("inventory_changed",self,"on_player_inventory_changed")

    
func _physics_process(delta):
    if Input.is_action_just_pressed("ui_inventory_left"):
        selected_slot = selected_slot-1 if selected_slot>1 else _slots.size()
        update_selected(selected_slot)
    if Input.is_action_just_pressed("ui_inventory_right"):
        selected_slot = selected_slot+1 if selected_slot<_slots.size() else 1
        update_selected(selected_slot)
        
        
func update_selected(slot):
    for s in _slots:
        if s.name == "Slot"+str(slot):
            s.get_node("Selection").visible=true
        else:
            s.get_node("Selection").visible=false

func update_slot(index,item,quantity):
    
    for s in _slots:
        if s.name == "Slot"+str(index+1):
            s.get_node("Quantity").text= str(quantity)
            s.get_node("ItemIcon").texture= item.item_reference.icon
            

            
            
func on_player_inventory_changed(inventory):
    for i in inventory._items.size():
        var item = inventory._items[i]
        #print(item.item_reference.name)
        update_slot(i , item , item.quantity)
    
    pass
