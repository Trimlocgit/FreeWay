extends RigidBody2D

var liste_spawn = [115, 345, 575, 805, 1035]
var gauchePrise = false
var droitePrise = false
var bouge = 0
var caseActuelle
var caseDepart = randi_range(0, 4)

signal bougeGauche
signal bougeDroite

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Si sort de l'écran alors est supprimé

func _ready() -> void:
	caseActuelle = caseDepart
	
func _process(delta: float) -> void:
	if bouge < 0:
		position.x -= 10
	elif bouge > 0:
		position.x += 10
	

func _on_devant_body_entered(body: Node2D) -> void:
	var velocite = Vector2.ZERO
	
	if !gauchePrise && caseActuelle != 0:
		bougeGauche.emit()
		bouge = -1
		caseActuelle -= 1
	elif caseActuelle != 4 && !droitePrise:
		bougeDroite.emit()
		bouge = 1
		caseActuelle += 1
		



func _on_devant_body_exited(body: Node2D) -> void:
	bouge = 0

#Vérifie si un élément est sur sa gauche
func _on_gauche_body_entered(body: Node2D) -> void:
	gauchePrise = true

func _on_gauche_body_exited(body: Node2D) -> void:
	gauchePrise = false

#Vérifie si un élément est sur sa droite
func _on_droite_body_entered(body: Node2D) -> void:
	droitePrise = true

func _on_droite_body_exited(body: Node2D) -> void:
	droitePrise = false
