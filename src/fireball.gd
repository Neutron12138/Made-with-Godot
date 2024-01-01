class_name Fireball extends Area2D

@export var damage : float = 5.0
@export var speed : Vector2 = Vector2.RIGHT * 1000.0
@export var team : Constants.Team = Constants.Team.PLAYER
@export var life : float = 5.0

var countdown : float = 0.1
var time : float = 0.0

func _process(delta: float) -> void:
	position += speed * delta
	countdown -= delta
	time += delta
	$path/follower.progress = randi_range(0,314)
	
	if time >= life:
		queue_free()
	
	if countdown <= 0.0:
		countdown = 0.1
		
		var p = Particle.new()
		p.position = $path/follower.position
		p.speed = -speed * 0.1
		$particles.add_child(p)

func _on_area_entered(area: Area2D) -> void:
	if area is Player or area is Monster:
		if area.team != team:
			area.get_damage(damage)
			queue_free()
	elif area is Fireball:
		queue_free()
