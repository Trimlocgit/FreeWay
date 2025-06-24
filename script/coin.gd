extends RigidBody2D

var caseActuelle
var caseDepart = randi_range(0, 4)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		queue_free()

func _ready() -> void:
	caseActuelle = caseDepart
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
