extends Node2D

var desplazamiento_ini = Vector2(0, 0)

func _ready():
	var t = get_tree().get_nodes_in_group("tangram")[0] #Busco la clase que dibuja y tiene vertices y toda la pijoleta
	for p in t.piezas: #Recorro todas las piezas
		p.disponible = true #Las habilito para dibujado
	desplazamiento_ini += Vector2(0, t.LADO_TRI_M)
	
	#Propiedades especificas del gato
	t.piezas[0].grados = 135.0
	t.piezas[0].pos_ini = Vector2(0,-t.LADO_TRI_M) + desplazamiento_ini
	t.piezas[1].grados = 90.0
	t.piezas[1].pos_ini = Vector2(-t.LADO_TRI_C,-t.LADO_TRI_C -t.LADO_TRI_M) + desplazamiento_ini
	t.piezas[2].grados = 270.0
	t.piezas[2].pos_ini = Vector2(-t.LADO_TRI_C,-t.LADO_TRI_C) + desplazamiento_ini
	t.piezas[3].grados = 90.0
	t.piezas[3].pos_ini = Vector2(-t.LADO_TRI_C*1.5,-t.LADO_TRI_C*2.5  -t.LADO_TRI_M) + desplazamiento_ini
	t.piezas[4].grados = 270.0
	t.piezas[4].pos_ini = Vector2(-t.LADO_TRI_C/2,-t.LADO_TRI_C*1.5 -t.LADO_TRI_M) + desplazamiento_ini
	t.piezas[5].grados = -45.0
	t.piezas[5].pos_ini = Vector2(-t.LADO_TRI_C,-t.LADO_TRI_C - t.LADO_TRI_M) + desplazamiento_ini
	t.piezas[6].grados =  -5.0
	t.piezas[6].pos_ini = Vector2(0.0, 0.0) + desplazamiento_ini
	
	t.actualizar()
