extends CanvasLayer

class_name UI

func set_lifes(lifes: int):
	%LifesLabel.text = "Lifes: %d" % lifes


func _on_game_lost_button_pressed():
	get_tree().reload_current_scene()
	
	
func game_over():
	$GameLostContainer.show()
