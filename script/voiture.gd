extends RigidBody2D

var liste_spawn = [115, 345, 575, 805, 1035]
var gauchePrise = false
var droitePrise = false
var caseActuelle
@export var caseDepart = randi_range(0, 4)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Si sort de l'écran alors est supprimé

func _ready() -> void:
	caseActuelle = caseDepart
	print(caseActuelle)
	

func _on_devant_body_entered(body: Node2D) -> void:
	var velocite = Vector2.ZERO
	
	if !gauchePrise && caseActuelle != 0:
		velocite.x -= 115
	#elif caseActuelle != 4:
		#caseActuelle += 1
		
	position += velocite
	
	#self.position.x = liste_spawn[caseActuelle]
	print(self.position.x)


#Vérifie si un élément est sur sa gauche
func _on_gauche_body_entered(body: Node2D) -> void:
	gauchePrise = true

func _on_gauche_body_exited(body: Node2D) -> void:
	gauchePrise = false
