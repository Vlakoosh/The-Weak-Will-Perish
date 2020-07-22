extends Area2D

signal nextLevel

func _on_Next_Room_body_entered(body):
	emit_signal("nextLevel")
	#Update the position vector when entering a new room (Or rather, every time the loop iterates at the start of the game)
	position.x +=240



