extends CanvasLayer

@onready var main = $"../"

func _on_button_reprendre_pressed() -> void:
	main.menuPauseFunc()


func _on_button_quitter_pressed() -> void:
	get_tree().quit()
