extends Node2D



var tailleEcran # Taille de l'écran (limite de jeux)


func _ready():
	tailleEcran = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocite = Vector2.ZERO
	velocite.y += 400
	
	position += velocite * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = Vector2.ZERO
