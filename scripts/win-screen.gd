extends Node2D

func _ready():
	$score/text.bbcode_text = "[right]"+str(int(global.score))

	for bonus_item in global.bonus_items_recovered:
		$bonus_items.get_node(bonus_item).show()
	if global.bonus_items_recovered.size() == 0:
		$bonus_items/none.show()

func next_scene():
	get_tree().change_scene("res://main-menu.tscn")