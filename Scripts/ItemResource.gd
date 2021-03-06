extends Resource
class_name ItemResource

enum Type{
    NONE,
    GENERIC,
    CONSUMABLE,
    EQUIPMENT
}
enum EquipmentType{
    NONE,
    WEAPON,
    ARMOR,
    ACESSORY
}

# Basic Properties
export var id:String
export var name:String
export var description:String = "This is an item"
export var stackable:bool = false
export var max_stack_size:int = 1
export var icon : Texture

export(Type) var type
export(EquipmentType) var equip_type

# Advanced Properties
export var damage : float = 0.0
export var defense : float = 0.0

export var onUse_consume : bool = false
export var onUse_heal : float = 0.0

