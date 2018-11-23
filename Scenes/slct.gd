extends TextureButton

var ref_v #Referencia a que vertice pertenece

func _ready():
	get_node("Ejes/X").text = String(round(ref_v.x / get_tree().get_nodes_in_group("tangram")[0].offset.x))
	get_node("Ejes/Y").text = String(round(ref_v.y / get_tree().get_nodes_in_group("tangram")[0].offset.x)*-1)

func _process(delta):
	if(Input.is_action_just_released("enter")):
		modificar_v()
	
func _on_slct_button_up(): #Si clickeo
	modulate = Color(0.4, 0.2, 0.6, 1) #Cambio de color
	get_node("Ejes").visible = true #Hago visible edicion de ejes
	for p in get_tree().get_nodes_in_group("slct"): #Recorro todos los vertices seleccionables
		if(p != self): #Si el vertice es justo el clickeado (o sea el actual)
			p.modulate = Color(1.0, 1.0, 1.0, 1) #Cambio a blanco
			p.get_node("Ejes").visible = false #Hago visible edicion de ejes

func _on_X_text_changed():
	if(abs(get_node("Ejes/X").text.to_float()) > get_tree().get_nodes_in_group("nivel")[0].unidad_x):
		if(get_node("Ejes/X").text.to_int() > 0): #Es positivo
			get_node("Ejes/X").text = String(get_tree().get_nodes_in_group("nivel")[0].unidad_x)
		else:
			get_node("Ejes/X").text = String(-get_tree().get_nodes_in_group("nivel")[0].unidad_x)

func _on_Y_text_changed():
	if(abs(get_node("Ejes/Y").text.to_float()) > get_tree().get_nodes_in_group("nivel")[0].unidad_x):
		if(get_node("Ejes/Y").text.to_int() > 0): #Es positivo
			get_node("Ejes/Y").text = String(get_tree().get_nodes_in_group("nivel")[0].unidad_x)
		else:
			get_node("Ejes/Y").text = String(-get_tree().get_nodes_in_group("nivel")[0].unidad_x)
		
func modificar_v(): #Modifica el vertice y lo vuelve a dibujar
	ref_v = Vector2(get_node("Ejes/X").text.to_int(), get_node("Ejes/Y").text.to_int())
	get_tree().get_nodes_in_group("tangram")[0].actualizar_figura()
