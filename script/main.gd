extends Node

@export var voiture_scene: PackedScene
var score = 0

func gameOver():
	$TimerScore.stop()
	$TimerVoiture.stop()
	
func newGame():
	score = 0
	$Player.start($PlayerStartPosition.position)
	$TimerStart.start()


func _on_timer_voiture_timeout() -> void:
	
	var voiture = voiture_scene.instantiate()
	
	var voiture_location = $PathVoiture/VoitureSpawnLocation
	voiture_location.progress_ratio = randf()
	
	voiture.position = voiture_location.position
	
	var direction = voiture_location.rotation + PI / 2
	
	voiture.rotation = direction
	
	var velocite = Vector2(randf_range(150, 250), 0)
	voiture.linear_velocity = velocite.rotated(direction)
	
	add_child(voiture)


func _on_timer_score_timeout() -> void:
	score += 1


func _on_timer_start_timeout() -> void:
	$TimerScore.start()
	$TimerVoiture.start()
