extends Node3D

var MAP_SIZE = 3
var NUM_POINTS_PER_AXIS = 16
var SURFACE_ISOVALUE

var TRI_TABLE = GameData.TRI_TABLE
var EDGE_TABLE = GameData.EDGE_TABLE


func _ready():
	_generate_triangle()


func _generate_triangle():
	var st = SurfaceTool.new()

	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	# Prepare attributes for add_vertex.
	st.set_normal(Vector3(0, 0, 1))
	st.set_uv(Vector2(0, 0))
	# Call last for each vertex, adds the above attributes.
	st.add_vertex(Vector3(-1, -1, 0))

	st.set_normal(Vector3(0, 0, 1))
	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(-1, 1, 0))

	st.set_normal(Vector3(0, 0, 1))
	st.set_uv(Vector2(1, 1))
	st.add_vertex(Vector3(1, 1, 0))

	# Commit to a mesh.
	var mesh = st.commit()
	$MeshInstance3D.mesh = mesh


func generate_grid():
	pass

func generate_mesh():
	var st = SurfaceTool.new()
	var mesh = MeshInstance3D.new()

	# generate map

	for x in range(-MAP_SIZE, MAP_SIZE):
		for y in range(-MAP_SIZE, MAP_SIZE):
			for z in range(-MAP_SIZE, MAP_SIZE):
				generate_vertices(x, y, z)

	# clean up mesh and commit
	st.generate_normals()
	st.index()

	var new_mesh = st.commit()
	$MeshInstance3D.set_mesh(new_mesh)


func generate_vertices(x, y, z):
	var corner_vertices = [
		[x, y, z],
		[x + 1, y, z],
		[x + 1, y + 1, z],
		[x, y + 1, z],
		[x, y, z + 1],
		[x + 1, y, z + 1],
		[x + 1, y + 1, z + 1],
		[x, y + 1, z + 1]
	]



