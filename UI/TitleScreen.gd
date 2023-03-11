extends Control

@export var setup_scene : PackedScene

func _on_start_game_button_button_up():
	get_tree().change_scene_to_packed(setup_scene)
