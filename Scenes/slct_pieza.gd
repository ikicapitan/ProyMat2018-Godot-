extends TextureButton

var pieza_referencia

func _ready():
	pass

func _on_slct_pieza_button_up():
	modulate = Color(0.0, 0.0, 0.0, 1) #Cambio de color
	for p in get_tree().get_nodes_in_group("slct_p"): #Recorro todas los select de las piezas
		if(p != self): #Si no es si mismo
			p.modulate = Color(1, 0.41, 0.71, 1) #Cambio a rosadito
	if get_tree().get_nodes_in_group("tangram")[0].target != pieza_referencia:
		get_tree().get_nodes_in_group("tangram")[0].target = pieza_referencia
		var vert_edit = get_tree().get_nodes_in_group("slct")
		if(vert_edit.size() > 0): #Si es mayor a 0, es porque hay vertices creados, solo actualizo valores
			get_tree().get_nodes_in_group("tangram")[0].actualizar_seleccion()
		else: #Sino, si es 0, es porque no habia vertices, tengo que crearlos
			get_tree().get_nodes_in_group("tangram")[0].actualizar()
