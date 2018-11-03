extends TextureButton


func _ready():
	pass



func _on_slct_button_up(): #Si clickeo
	modulate = Color(0.4, 0.2, 0.6, 1) #Cambio de color
	get_node("Ejes").visible = true #Hago visible edicion de ejes
	for p in get_tree().get_nodes_in_group("slct"): #Recorro todos los vertices seleccionables
		if(p != self): #Si el vertice es justo el clickeado (o sea el actual)
			p.modulate = Color(1.0, 1.0, 1.0, 1) #Cambio a blanco
			p.get_node("Ejes").visible = false #Hago visible edicion de ejes
