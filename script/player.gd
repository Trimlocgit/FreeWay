extends Area2D


@export var vitesse = 300 # Vitesse du joueur
var tailleEcran # Taille de l'écran (limite de jeux)


func _ready():
	tailleEcran = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocite = Vector2.ZERO
	
	if (Input.is_action_pressed("droite")):
		velocite.x += vitesse
	if (Input.is_action_pressed("gauche")):
		velocite.x -= vitesse
		
	position += velocite * delta
	position = position.clamp(Vector2.ZERO, tailleEcran)
