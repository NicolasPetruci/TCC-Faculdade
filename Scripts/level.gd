extends ParallaxBackground

@export var start_speed := 200.0
var acceleration := 10.0
var current_speed := start_speed

func _process(delta):
	current_speed += acceleration * delta
	scroll_offset.y += current_speed * delta
