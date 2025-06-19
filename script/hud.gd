extends CanvasLayer


signal start_game

func showMessage(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	

func showGameOver():
	showMessage("Game Over")
	await $MessageTimer.timeout
	
	$Message.text = "Evite les voitures"
	$Message.show()
	
	await get_tree().create_timer(1).timeout
	$StartButton.show()
	

func scoreUpdate(score):
	$ScoreLabel.text = str(score)
	

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
