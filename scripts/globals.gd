extends Node

const NUM_FRAMES = 800
const MAX_POPULATION = 15
const FPS = 60

onready var num_of_dead_birds = 0
var mating_pool = []
var candidates_chances = []
var population = []

var current_generation = 1

const GENE_BY_GENE = 0
const HALF_EACH = 1

onready var bird = preload('res://scenes/birds/bird.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_candidate_for_next_generation(candidate):
	var current_index = len(mating_pool)
	for i in range(candidate.fitness * candidate.fitness):
		candidates_chances.append(current_index)
	mating_pool.append(candidate)


func crossover():
	for i in range(MAX_POPULATION):
		randomize()
		var partner_A = mating_pool[randi() % len(mating_pool)]
		var partner_B = mating_pool[randi() % len(mating_pool)]
		
		var new_bird = bird.instance()
		new_bird._init()
		
		var type = randi() % 2
		
		if type == GENE_BY_GENE:
			for i in range(FPS * NUM_FRAMES):
				randomize()
				if randi() % 2 == 0:
					# new_bird.genes[i] = partner_A.genes[i]
					new_bird.genes.append(partner_A.genes[i])
				if randi() % 2 == 1:
					# new_bird.genes[i] = partner_B.genes[i]
					new_bird.genes.append(partner_B.genes[i])
				"""
				if randi() % 2 == 1:
					partner_A.genes[i] = partner_B.genes[i]
				"""
		elif type == HALF_EACH:
			"""
			for i in range((FPS * NUM_FRAMES) / 2):
				partner_A.genes[i + ((FPS * NUM_FRAMES) / 2)] = partner_B.genes[i + ((FPS * NUM_FRAMES) / 2)]
			"""
			for i in range(FPS * NUM_FRAMES):
				if i <= (FPS * NUM_FRAMES) / 2:
					# new_bird.genes[i] = partner_A.genes[i]
					new_bird.genes.append(partner_A.genes[i])
				else:
					# new_bird.genes[i] = partner_B.genes[i]
					new_bird.genes.append(partner_B.genes[i])
				
		"""
		partner_A.died = false
		partner_A.has_collided = false
		partner_A.has_collided_with_ground = false
		partner_A.current_gene = 0
		partner_A.fitness = 0
		partner_A.has_just_flap = false
		population.append(partner_A)
		"""
		population.append(new_bird)

	
func mutation():	
	for i in range(MAX_POPULATION):
		var mutados = 0
		randomize()
		for j in population[i].genes:
			if rand_range(0, 100) < 1:
				mutados += 1
				population[i].genes[j] = 0 if population[i].genes[j] == 1 else 1
		if mutados > 0:
			print(mutados, ' genes mutados')

func generate_next_generation():
	population.clear()
	crossover()
	mutation()
	current_generation += 1
	mating_pool.clear()