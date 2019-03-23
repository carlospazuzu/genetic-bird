extends Node2D

onready var bird = preload('res://scenes/birds/bird.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range($"/root/globals".MAX_POPULATION):
		var b = bird.instance()
		b.position = Vector2(200, 225)
		add_child(b)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print("quantidade atual de filhos mortos ", $"/root/globals".num_of_dead_birds)
	# print('quantidade atual de filhos ', get_child_count())
	if $"/root/globals".num_of_dead_birds == get_child_count():
		$"/root/stage/tilemap".position = Vector2(0, 0)
		$"/root/globals".generate_next_generation()
		for child in get_children():
			remove_child(child)
			$"/root/globals".num_of_dead_birds -= 1
		
		for p in $"/root/globals".population:
			p.position = Vector2(200, 225)
			add_child(p)
		
		$"/root/stage/label".text = "GENERATION " + str($"/root/globals".current_generation)
		

