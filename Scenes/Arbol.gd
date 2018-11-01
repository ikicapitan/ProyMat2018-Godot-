extends Node2D

func _ready():
	var t = get_tree().get_nodes_in_group("tangram")[0] #Busco la clase que dibuja y tiene vertices y toda la pijoleta
	for p in t.piezas: #Recorro todas las piezas
		p.disponible = true #Las habilito para dibujado
	
	#Propiedades especificas del gato
	t.piezas[0].grados = 225.0
	t.piezas[0].pos_ini = Vector2(4.0,0.0)
	t.piezas[1].pos_ini = Vector2(0.0,-4.0)
	t.piezas[1].grados = 135.0
	t.piezas[2].grados = 0.0
	t.piezas[2].pos_ini = Vector2(-2.0,-4.0)
	t.piezas[3].grados = 45.0
	t.piezas[3].pos_ini = Vector2(0.0, -4.0)
	t.piezas[4].grados = 225.0
	t.piezas[4].pos_ini = Vector2(4.0, -2.0)
	t.piezas[5].grados = 0.0
	t.piezas[5].pos_ini = Vector2(-1.0,2.0)
	t.piezas[6].grados =  135.0
	t.piezas[6].pos_ini = Vector2(-4.0, -2.0)
	t.piezas[6].flipped = true

	
	t.actualizar()
