extends ParallaxBackground

const SPEED = -60

# Called when the node enters the scene tree for the first time.
func _ready():
	$parallax_layer.motion_mirroring = $parallax_layer/sprite.texture.get_size().rotated($parallax_layer/sprite.global_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scroll = Vector2(SPEED, 0)
	scroll *= delta
	self.scroll_offset += scroll
