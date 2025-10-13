extends ParallaxBackground


func _physics_process(delta):
	scroll_offset.y += GameManeger.world_speed * delta
