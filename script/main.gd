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
	
	var voiture = voiture_scene.instantiate()
	var liste_spawn = [115, 345, 575, 805, 1035]
	var voiture_location = $PathVoiture/VoitureSpawnLocation
	voiture_location.progress_ratio = randf()
	
	voiture_location.position.x = liste_spawn[randf_range(0, 5)]
	
	voiture.position = voiture_location.position
	print(voiture.position)
	
	var direction = voiture_location.rotation + PI / 2
	
	voiture.rotation = direction
	
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
