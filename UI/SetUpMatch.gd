extends Control

@export var menu_scene : PackedScene
@export var dm_scene : PackedScene
@export var tdm_scene : PackedScene
@export var ctf_scene : PackedScene
@export var custom_scene : PackedScene

func _on_menu_button_button_up():
	get_tree().change_scene_to_packed(menu_scene)

func _on_dm_button_button_up():
	get_tree().change_scene_to_packed(dm_scene)

func _on_tdm_button_button_up():
	get_tree().change_scene_to_packed(tdm_scene)

func _on_ctf_button_button_up():
	get_tree().change_scene_to_packed(ctf_scene)

func _on_custom_button_button_up():
	get_tree().change_scene_to_packed(custom_scene)
