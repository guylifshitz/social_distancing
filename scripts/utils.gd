# script: utils

extends Node

var main_node setget , _get_main_node
var view_size setget , _get_view_size
var mouse_pos setget , _get_mouse_pos

func _ready():
	pass

func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass

func create_timer_2(wait_time, obj, callback_name):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	timer.connect("timeout", obj, callback_name)
	add_child(timer)
	timer.start()
	return timer
	pass

func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]
	pass

func attach(src_node, src_signal, trg_node, trg_func):
	if typeof(src_node) == TYPE_STRING:
		src_node = find_node(src_node)
	
	if typeof(trg_node) == TYPE_STRING:
		trg_node = find_node(trg_node)
	
	if src_node != null and trg_node != null:
		src_node.connect(src_signal, trg_node, trg_func)
	pass

func remote_call(src_node, method, arg0 = null, arg1 = null):
	src_node = find_node(src_node)
	
	if src_node and src_node.has_method(method):
		if arg0 and arg1:
			return src_node.call(method, arg0, arg1)
		if arg0:
			return src_node.call(method, arg0)
		
		return src_node.call(method)
	pass

func _get_mouse_pos():
	return get_viewport()
	.get_mouse_pos()
	pass

func _get_main_node():
	var root = get_tree().get_root()
	return root.get_child( root.get_child_count()-1 )
	pass

func _get_view_size():
	return get_tree().get_root().get_visible_rect().size
	pass

## ADDED ##
func load_json(json_path):
	var file = File.new()
	file.open(json_path, file.READ)
	var json_text = file.get_as_text()
	file.close()
	var result_json = JSON.parse(json_text)
	
	if result_json.error == OK:
		return result_json.result
	else:  # If parse has errors
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
		return
		
