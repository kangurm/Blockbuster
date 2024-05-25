extends Node2D

var countdown_time = 60

func _input (event):
	if Input.is_action_just_pressed("mb_left"):
		$OneSecondTimer.start()





func _on_countdown_tick():
	if countdown_time > 0:
		countdown_time -= 1
		$Label.text = str(countdown_time)
		$ProgressBar.value = 60 - countdown_time
		if countdown_time == 0:
			$OneSecondTimer.stop()

