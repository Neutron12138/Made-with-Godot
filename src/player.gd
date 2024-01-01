class_name Player extends Area2D

@export var speed : float = 500.0
@export var sprint_speed : float = 1000.0
@export var max_health : float = 50.0
@export var cooldown : float = 0.5
@export var team : Constants.Team = Constants.Team.PLAYER

@onready var player : AnimationPlayer = $player
@onready var health_bar : ProgressBar = $health_bar

var health : float = max_health
var cd : float = 0.0

func _ready() -> void:
	health_bar.max_value = max_health
	update_health_bar()

func _process(delta: float) -> void:
	var spd = speed
	if Input.is_action_pressed("sprint"):
		spd = sprint_speed
	
	if Input.is_action_just_pressed("right"):
		scale.x = 1.0
	if Input.is_action_just_pressed("left"):
		scale.x = -1.0
	if Input.is_action_just_released("right"):
		player.stop()
	if Input.is_action_just_released("left"):
		player.stop()
	
	if Input.is_action_pressed("right"):
		player.play("walk")
		position.x += spd * delta
	if Input.is_action_pressed("left"):
		player.play("walk")
		position.x += -spd * delta
	
	cd -= delta

func get_damage(damage : float) -> void:
	health -= damage
	update_health_bar()

func update_health_bar() -> void:
	health_bar.value = health
