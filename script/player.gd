extends Area2D

signal hit
signal plusCoin

@export var vitesse = 300 # Vitesse du joueur
var tailleEcran # Taille de l'écran (limite de jeux)
#var vie = 2 # Nombre de vie du joueur


func _ready():
	tailleEcran = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocite = Vector2.ZERO
	
	if (Input.is_action_pressed("droite")):
		velocite.x += vitesse
	if (Input.is_action_pressed("gauche")):
		velocite.x -= vitesse
	if(Input.is_action_pressed("Accelerer")):
		velocite.y -= vitesse/3
	if(Input.is_action_pressed("Ralentire")):
		velocite.y += vitesse
	
	position += velocite * delta
	position = position.clamp(Vector2.ZERO, tailleEcran)

func sauvegarde():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		#"skinActuel" : $Sprite2D
		}

func _on_body_entered(body: Node2D) -> void:
	if body.name == "voiture":
		hit.emit()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
	elif body.name == "coin":
		print("+1")
		plusCoin.emit()
	

#Fonction appelé lors du lancement d'une nouvelle partie
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
