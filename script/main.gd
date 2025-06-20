extends Node

@export var voiture_scene: PackedScene
var score

func gameOver():
	$TimerScore.stop()
	$TimerVoiture.stop()
	$HUD.showGameOver()
	
func newGame():
	score = 0
	get_tree().call_group("voitures", "queue_free")
	$HUD.scoreUpdate(score)
	$HUD.showMessage("Prépare toi !")
	$Player.start($PlayerStartPosition.position)
	$TimerStart.start()

func _ready() -> void:
	pass

func _on_timer_voiture_timeout() -> void:
	#Peut être opti
	var voiture = voiture_scene.instantiate()
	var liste_spawn = [115, 345, 575, 805, 1035]
	var voiture_location = $PathVoiture/VoitureSpawnLocation
	voiture_location.progress_ratio = randf()
	
	#Choisit une des quatres voie
	voiture_location.position = Vector2(liste_spawn[voiture.caseDepart], 0)
	
	voiture.position = voiture_location.position
	
	#Met la voiture perpendiculaire
	var direction = voiture_location.rotation + PI / 2
	
	#voiture.rotation = direction
	#Varie la vitesse de la voiture
	var velocite = Vector2(randf_range(150 + score, 250 + score), 0)
	voiture.linear_velocity = velocite.rotated(direction)
	
	add_child(voiture)


func _on_timer_score_timeout() -> void:
	score += 1
	$HUD.scoreUpdate(score)


func _on_timer_start_timeout() -> void:
	$TimerScore.start()
	$TimerVoiture.start()


func _on_hud_start_game() -> void:
	newGame()


func _on_player_hit() -> void:
	gameOver()
