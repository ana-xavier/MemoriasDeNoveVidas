extends Control

@onready var slots_grid: GridContainer = $SlotsGrid
@onready var secret_items_grid: GridContainer = $SecretItems/SecretItemsGrid

const secret_item_scene = preload("res://gui/inventory/scenes/secret_item_slot.tscn")
const INVENTORY_SIZE = 20

var items_dict: Dictionary

func _ready():
	load_secret_items()

func updade_items_displayed():
	clear_inventory()
	
	items_dict = InventoryManager.get_all()
	if !items_dict.is_empty():
		update_basic_items()
		
	update_secret_items()
	
func update_basic_items():	
	var curr_slot: int = 0
	for item_id in items_dict.keys():
		if curr_slot >= INVENTORY_SIZE:
			return
			
		var item_data = ItemsData.get_item_data_by_id(item_id) as Item
		
		if item_data.category == Item.Category.BASIC:
			var slot = slots_grid.get_child(curr_slot)
			slot.display_item(item_data, items_dict.get(item_id))
			curr_slot += 1

func clear_inventory():
	for i in range(INVENTORY_SIZE):
		var slot = slots_grid.get_child(i)
		slot.clear()
	
func load_secret_items():
	var secret_items: Array[Item] = ItemsData.get_all_secret_items()
	for item in secret_items:
		var item_slot_instance = secret_item_scene.instantiate()
		secret_items_grid.add_child(item_slot_instance)
		item_slot_instance.add_item_data(item)
		

func update_secret_items():
	for slot in secret_items_grid.get_children() as Array[SecretItemSlot]:
		var item_id: String = slot.item.id
		if !slot.has_item && InventoryManager.has_item(item_id):
			slot.show_item()
