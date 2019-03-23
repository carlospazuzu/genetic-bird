extends RigidBody2D

const ZERO_VECTOR = Vector2(0, 0)

var genes = []
var current_gene = 0
var fitness = 0

var has_just_flap = false
var state_machine

onready var has_collided = false
onready var has_collided_with_ground = false
onready var died = false

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $animation_tree['parameters/playback']
	state_machine.start('idle')
	for i in range($"/root/globals".FPS * $"/root/globals".NUM_FRAMES):
		genes.append(0 if rand_range(0, 100) <= 95 else 1)


func _process(delta):
	if current_gene < $"/root/globals".FPS * $"/root/globals".NUM_FRAMES and genes[current_gene] and not has_collided:
		has_just_flap = true
		linear_velocity.y = 0
		self.apply_impulse(ZERO_VECTOR, Vector2(0, -300))
		
	current_gene += 1
	
	if has_just_flap:
		$sprite.rotation -= 0.1
	else:
		$sprite.rotation += 0.1
		
	if linear_velocity.y > 0:
		has_just_flap = false
		
	if linear_velocity.y < 0:
		state_machine.travel('flapping')
	if linear_velocity.y > 0:
		state_machine.travel('idle')
	
	if $sprite.rotation <= -(PI / 4):
		$sprite.rotation = -(PI / 4)
	
	if $sprite.rotation >= PI / 2:
		$sprite.rotation = PI / 2
		
	if not has_collided:
		fitness += 1
		
	if position.y < 0:
		has_collided = true
		
	if has_collided and not died:
		died = true
		$"/root/globals".num_of_dead_birds += 1
		$"/root/globals".add_candidate_for_next_generation(self)
		



func _on_bird_body_entered(body):
	if body.name == 'ground' and died:
		# has_collided_with_ground = true
		set_process(false)
	has_collided = true
