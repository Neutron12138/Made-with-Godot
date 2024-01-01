class_name Particle extends MeshInstance2D

@export var speed : Vector2 = Vector2.LEFT * 100.0
@export var color : Color = Color.YELLOW
@export var life : float = 1.0

var time : float = 0.0

func _ready() -> void:
	var vertices = PackedVector2Array()
	vertices.push_back(Vector2(10, 10))
	vertices.push_back(Vector2(-10, 10))
	vertices.push_back(Vector2(-10, -10))
	vertices.push_back(Vector2(10, -10))
	
	var colors = PackedColorArray()
	colors.push_back(color)
	colors.push_back(color)
	colors.push_back(color)
	colors.push_back(color)
	
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_COLOR] = colors
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_STRIP, arrays)


func _process(delta: float) -> void:
	position += speed * delta
	time += delta
	
	if time >= life:
		queue_free()
