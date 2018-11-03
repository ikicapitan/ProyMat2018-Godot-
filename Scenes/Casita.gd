extends Node2D

func _ready():
	var t = get_tree().get_nodes_in_group("tangram")[0] #Busco la clase que dibuja y tiene vertices y toda la pijoleta
	for p in t.piezas: #Recorro todas las piezas
		p.disponible = true #Las habilito para dibujado
	
	#Propiedades especificas de la casa
	t.piezas[1].pos_ini = Vector2(t.LADO_CUADR /2, -t.LADO_TRI_C)
	t.piezas[2].grados = 315.0
	t.piezas[2].pos_ini = Vector2(0.0,0.0)
	t.piezas[3].grados = 180.0
	t.piezas[3].pos_ini = Vector2(t.LADO_TRI_G, -t.LADO_TRI_C)
	t.piezas[4].grados = 270.0
	t.piezas[4].pos_ini = Vector2(t.LADO_TRI_G, 0)
	t.piezas[5].pos_ini = Vector2(t.LADO_CUADR /2,-t.LADO_TRI_C -t.LADO_CUADR)
	t.piezas[6].grados =  135.0
	t.piezas[6].flipped = true
	t.piezas[6].pos_ini = Vector2(-t.LADO_CUADR /2, -t.LADO_TRI_C)
	
	t.actualizar()
