extends Camera


export(float) var intensity := 0.7
export(float) var duration := 0.1

var current_shake_duration := 0.0

onready var noise := OpenSimplexNoise.new()

func _ready():
	noise.seed = randi()
	noise.octaves = 8
	noise.period = 20.0
	noise.persistence = 0.7


func _physics_process(delta):
	if current_shake_duration <= 0.0:
		if h_offset != 0.0 or v_offset != 0.0:
			h_offset = 0.0
			v_offset = 0.0
			current_shake_duration = 0.0
		return
	
	current_shake_duration -= delta
	
	h_offset = noise.get_noise_1d(OS.get_ticks_msec() * 0.1) * intensity
	v_offset = noise.get_noise_1d(OS.get_ticks_msec() * 0.1 + 100.0) * intensity


func shake():
	current_shake_duration = duration
