extends KinematicBody2D

var prev_x = 0
var prev_y = 0
var base_scale = 0.5
var remote_path_follow
var remote_transform
var sprite

var MOVE_SPEED

func _ready():
	var speed_lower_bound = global.level_settings["motorcycle"]["move_speed_lower"]
	var speed_upper_bound = global.level_settings["motorcycle"]["move_speed_upper"]
	MOVE_SPEED = rand_range(speed_lower_bound,speed_upper_bound) 
	
	$red.hide()
	$black.hide()
	if randf() > 0.7:
		sprite = $red
	else:
		sprite = $black
	sprite.show()

	remote_path_follow.offset = randi() % 10000

func _process(delta):
	#self.get_parent().offset += 500 * delta;
	
	#global_position = Vector2(500,500)
	remote_path_follow.offset += MOVE_SPEED  * delta
	self.global_position = remote_transform.global_position
	if prev_x < self.global_position.x and prev_y > self.global_position.y:
		self.scale = Vector2(base_scale, base_scale)
		sprite.play("up")
	elif prev_x < self.global_position.x and prev_y < self.global_position.y:
		self.scale = Vector2(-base_scale, base_scale)
		sprite.play("down")
	elif prev_x > self.global_position.x and prev_y < self.global_position.y:
		self.scale = Vector2(base_scale, base_scale)
		sprite.play("down")
	else:
		self.scale = Vector2(-base_scale, base_scale)
		sprite.play("up")
	prev_x = global_position.x
	prev_y = global_position.y
