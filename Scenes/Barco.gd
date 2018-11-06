extends Node2D

func _ready():
	var t = get_tree().get_nodes_in_group("tangram")[0] #Busco la clase que dibuja y tiene vertices y toda la pijoleta
	for p in t.piezas: #Recorro todas las piezas
		p.disponible = true #Las habilito para dibujado
	
	#Propiedades especificas del gato
	t.piezas[1].grados = 90.0
	t.piezas[1].pos_ini = Vector2(0.0,-t.LADO_TRI_G)
	t.piezas[2].grados = 180.0
	t.piezas[2].pos_ini = Vector2(t.LADO_TRI_C,0.0)
	t.piezas[3].grados = 135.0
	t.piezas[3].pos_ini = Vector2(-t.LADO_CUADR, -t.LADO_CUADR)
	t.piezas[4].grados = 135.0
	t.piezas[4].pos_ini = Vector2(0.0, -t.LADO_TRI_M)
	t.piezas[5].pos_ini = Vector2(-t.LADO_CUADR,0.0)
	t.piezas[6].grados =  45.0
	t.piezas[6].pos_ini = Vector2(-t.LADO_TRI_M *1.5 + t.LADO_TRI_C, 0.0)
	
	t.actualizar()
