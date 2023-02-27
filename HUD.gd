extends Control

signal start

func updateScore(score):
	$Label.text = str(score)

func updateLives(lives):
	$Lives.text = "Lives: " + str(lives)

func preGame():
	$Button.show()
	$Label2.show()

func duringGame():
	$Button.hide()
	$Label2.hide()
	
func _input(event):
	if event is InputEventKey:
		if event.as_text_key_label() == "Enter":
			$Button.emit_signal("pressed")


func _on_button_pressed():
	emit_signal("start")
