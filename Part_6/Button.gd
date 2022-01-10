extends Button


func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://level1.tscn")
