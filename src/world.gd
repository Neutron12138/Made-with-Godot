class_name World extends Node2D

@onready var fireballs : Node2D = $fireballs
@onready var monsters : Node2D = $monsters
@onready var camera : Camera2D = $camera
@onready var player : Area2D = $player
@onready var gameover_label : Label = $UHD/gameover_label
@onready var kills_count_label : Label = $UHD/kills_count_label

var kills_count : int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	camera.position = player.position - Vector2(0, 400)
	kills_count_label.text = "Kills: " + str(kills_count)
	
	if player.health <= 0.0:
		process_mode = Node.PROCESS_MODE_DISABLED
		gameover_label.show()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if player.cd <= 0.0:
					var pos = get_mouse_position(event.position)
					var dir = pos - (player.position + Vector2(0.0, -400.0))
					player_attack(dir.normalized())

func player_attack(direction : Vector2) -> void:
	var fb = Constants.FireballScene.instantiate()
	fb.position = player.position + Vector2(0.0, -400.0) + direction * 400.0
	fb.speed = direction * 1000.0
	fireballs.add_child(fb)
	player.cd = player.cooldown

func get_mouse_position(scrpos : Vector2) -> Vector2:
	var vptsize = get_window().get_viewport().size
	return camera.position + (-vptsize / 2.0 + scrpos) / camera.zoom

func _on_timer_timeout() -> void:
	if monsters.get_child_count() >= 2:
		return
	
	var px = player.position.x as int
	var x
	if randi_range(0, 1) == 0:
		x = randi_range(-2500 + px, -1500 + px)
	else:
		x = randi_range(1500 + px, 2500 + px)
	var m = Constants.MonsterScene.instantiate()
	m.position.x = x
	monsters.add_child(m)
