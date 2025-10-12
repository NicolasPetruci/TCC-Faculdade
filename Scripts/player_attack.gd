extends Area2D

var damage = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.connect("animation_finished", Callable(self, "_on_animated_sprite_2d_animation_finished"))
	$AnimatedSprite2D.connect("animation_looped", Callable(self, "_on_animated_sprite_2d_animation_finished"))
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(direction):
	match(direction):
		Vector2.UP:
			position += Vector2(0, -10)
		Vector2.DOWN:
			rotate(-PI)
			position += Vector2(0, 10)
		Vector2.RIGHT:
			rotate(PI/2)
			position += Vector2(20, 0)
		Vector2.LEFT:
			rotate(-PI/2)
			position += Vector2(-20, 0)
		Vector2.LEFT + Vector2.UP:
			rotate(-PI/4)
			position += Vector2(-20, -10)
		Vector2.LEFT + Vector2.DOWN:
			rotate(-PI/4 - PI/2)
			position += Vector2(-20, 10)
		Vector2.RIGHT + Vector2.UP:
			rotate(PI/4)
			position += Vector2(20, -10)
		Vector2.RIGHT + Vector2.DOWN:
			rotate(PI/4 + PI/2)
			position += Vector2(20, 10)


func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
