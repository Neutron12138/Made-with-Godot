class_name Monster extends Area2D

@export var speed : float = 200.0
@export var max_health : float = 10.0
@export var cooldown : float = 2.0
@export var team : Constants.Team = Constants.Team.ENEMY

@onready var health_bar : ProgressBar = $health_bar
@onready var player : Player = get_tree().get_root().get_node("World/player")
@onready var fireballs : Node2D = get_tree().get_root().get_node("World/fireballs")
@onready var world : World = get_tree().get_root().get_node("World")

var health : float = max_health
var cd : float = 0.0

func _ready() -> void:
	health_bar.max_value = max_health
	update_health_bar()

func _process(delta: float) -> void:
	cd -= delta
	
	if health <= 0.0:
		world.kills_count += 1
		queue_free()
	
	if scan_enemy():
		if cd <= 0.0:
			attack()

func get_damage(damage : float) -> void:
	health -= damage
	update_health_bar()

func update_health_bar() -> void:
	health_bar.value = health

func scan_enemy() -> bool:
	return (player.global_position - global_position).length() <= 2500.0

func attack() -> void:
	var ppos = player.global_position
	var pos = global_position
	var dir = (ppos - pos).normalized()
	var dirx = dir
	dirx.y = 0.0
	dirx = dirx.normalized()
	
	if dir.x < 0:
		scale.x = -1.0
	else:
		scale.x = 1.0
	
	var fb = preload("res://src/fireball.tscn").instantiate()#Constants.FireballScene.instantiate()
	fb.position = pos + Vector2(0.0, -400.0) + dirx * 400.0
	fb.speed = dirx * 1000.0
	fb.team = Constants.Team.ENEMY
	fireballs.add_child(fb)
	
	cd = cooldown
