extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (self.paused == false):
		print(self.time_left)	
	pass

func activate_timer():
	self.start(60)
