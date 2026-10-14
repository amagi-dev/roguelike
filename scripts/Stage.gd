extends TileMapLayer
class_name Stage

func _ready() -> void:
	pass



func get_info_from_cell(object: Actor,cell: Vector2i) -> Dictionary:

	var c = get_cell_from_position(object.global_position);
	c += cell;



	var source_id = get_cell_source_id(c)

	if source_id == -1:
		return { "exists": false }


	var tile_data = get_cell_tile_data(cell)

	var is_wall = false

	if tile_data:
		is_wall = tile_data.get_custom_data("is_wall")
	pass


	return {
		"exists": true,
		"is_wall": is_wall
	}
pass



# Get global_position from cell
func get_position_from_cell(cell: Vector2i) -> Vector2:
	var local = map_to_local(cell)
	var global = to_global(local)

	return global
pass

# Get cell from the global_position
func get_cell_from_position(global: Vector2) -> Vector2i:
	var local = to_local(global)
	var cell = local_to_map(local)

	return cell
pass
