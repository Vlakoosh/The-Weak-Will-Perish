extends Node

signal nextLevel


func _on_Next_Room_nextLevel():
	emit_signal("nextLevel")
