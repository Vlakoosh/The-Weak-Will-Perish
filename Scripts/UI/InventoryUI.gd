extends Control


var _slots = Array()
var player
var selected_slot = 1

onready var inventory_slot = preload("res://Scenes/UI/InventorySlot.tscn")

func _ready():
    GameManager.connect("player_initialized",self,"on_player_init")
    
    
    
func on_player_init(player):
    for i in player.inventory._item_slots.size():
            
        var new_inventory_slot = inventory_slot.instance()
        $Slots.add_child(new_inventory_slot)
        new_inventory_slot.slot_type= player.inventory._item_slots[i].slot_type
        new_inventory_slot.name="Slot"+str(i)
        new_inventory_slot.title=str(i+1)
        new_inventory_slot.index=i+1
        
    for c in $Slots.get_children():
        _slots.append( c )
        
    #update_selected(1)
    
    pass
    
func _process(delta):
    if not player:
        player = GameManager.player
        player.inventory.connect("inventory_changed",self,"on_player_inventory_changed")
        
    
func _physics_process(delta):
    pass
#    if Input.is_action_just_pressed("ui_inventory_left"):
#        selected_slot = selected_slot-1 if selected_slot>1 else _slots.size()
#        update_selected(selected_slot)
#    if Input.is_action_just_pressed("ui_inventory_right"):
#        selected_slot = selected_slot+1 if selected_slot<_slots.size() else 1
#        update_selected(selected_slot)
        
        
func update_selected(index):
    for s in _slots:
        if s.index == index:
            s.is_selected = true
        else:
            s.is_selected = false

func update_slot(index,slot):
    
    for s in _slots:
        if s.index == index+1:
            s.quantity = slot.quantity
            s.item_reference = slot.item_reference
            s.slot_type = slot.slot_type
            
            
func on_player_inventory_changed(inventory):
    for i in inventory._item_slots.size():
        var slot = inventory._item_slots[i]
        #print(item.item_reference.name)
        update_slot(i , slot )
    
    pass
