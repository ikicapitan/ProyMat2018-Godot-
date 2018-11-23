extends Node2D

export (int) var unidad_x #Cuantos casilleros habra en X
export (int) var unidad_y #Cuantos casilleros habra en Y
export (int) var grosor_lineas
export (int) var largo_lineas
export (int) var distancia_texto
var resolucion = Vector2() #Resolucion de pantalla
var dim_offset #Separacion de cada casillero (distancia)

func _ready():
	resolucion = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	
func _draw(): #Vamos a dibujar los ejes cartesianos
	dim_offset = Vector2() 
	dim_offset = resolucion / Vector2(unidad_x * 2, unidad_y * 2)

	draw_line(Vector2(-512,0), Vector2(512,0), Color(1,0,0,1),grosor_lineas) #Dimension en ancho X
	draw_line(Vector2(0,-300), Vector2(0,300), Color(1,0,0,1),grosor_lineas) #Dimension en alto Y
	
	for x in unidad_x: #Recorro casillero en X positivo para dibujar linitas segun offset
		draw_line(Vector2((x+1) * dim_offset.x, largo_lineas), Vector2((x+1) * dim_offset.x, -largo_lineas), Color(1,0,0,1), grosor_lineas)
		draw_line(Vector2((x+1) * dim_offset.x, resolucion.y/2), Vector2((x+1) * dim_offset.x, -resolucion.y/2), Color(1,1,1,0.05), grosor_lineas)
		var newTxt = get_tree().get_nodes_in_group("main")[0].txt_cartes.instance() #Creamos texto de numero de grilla
		newTxt.text = String(x+1)
		add_child(newTxt)
		newTxt.rect_position = Vector2((x+1) * dim_offset.x - newTxt.rect_size.x/2, distancia_texto)
		
	for x in unidad_x: #Recorro casillero en X negativo para dibujar linitas segun offset
		draw_line(Vector2((x+1) * -dim_offset.x, largo_lineas), Vector2((x+1) * -dim_offset.x, -largo_lineas), Color(1,0,0,1), grosor_lineas)
		draw_line(Vector2((x+1) * -dim_offset.x, resolucion.y/2), Vector2((x+1) * -dim_offset.x, -resolucion.y/2), Color(1,1,1,0.05), grosor_lineas)		
		var newTxt = get_tree().get_nodes_in_group("main")[0].txt_cartes.instance() #Creamos texto de numero de grilla
		newTxt.text = String(-(x+1))
		add_child(newTxt)
		newTxt.rect_position = Vector2((x+1) * -dim_offset.x - newTxt.rect_size.x/2, distancia_texto)

	for y in unidad_y: #Recorro casillero en Y positivo para dibujar linitas segun offset
		draw_line(Vector2(largo_lineas,(y+1) * dim_offset.x), Vector2(-largo_lineas,(y+1) * dim_offset.x), Color(1,0,0,1), grosor_lineas)
		draw_line(Vector2(resolucion.y,(y+1) * dim_offset.x), Vector2(-resolucion.y,(y+1) * dim_offset.x), Color(1,1,1,0.05), grosor_lineas)
		var newTxt = get_tree().get_nodes_in_group("main")[0].txt_cartes.instance() #Creamos texto de numero de grilla
		newTxt.text = String(-(y+1))
		add_child(newTxt)
		newTxt.rect_position = Vector2(distancia_texto, (y+1) * dim_offset.x - newTxt.rect_size.y/2)
		
	for y in unidad_y: #Recorro casillero en Y positivo para dibujar linitas segun offset
		draw_line(Vector2(largo_lineas,(y+1) * -dim_offset.x), Vector2(-largo_lineas,(y+1) * -dim_offset.x), Color(1,0,0,1), grosor_lineas)
		draw_line(Vector2(resolucion.y,(y+1) * -dim_offset.x), Vector2(-resolucion.y,(y+1) * -dim_offset.x), Color(1,1,1,0.05), grosor_lineas)
		var newTxt = get_tree().get_nodes_in_group("main")[0].txt_cartes.instance() #Creamos texto de numero de grilla
		newTxt.text = String((y+1))
		add_child(newTxt)
		newTxt.rect_position = Vector2(distancia_texto, (y+1) * -dim_offset.x - newTxt.rect_size.y/2)
	
	#Una vez cargado toda la Intefaz del nivel, cargamos tangrama
	cargar_tangrama()
	cargar_pieza()
	
func cargar_tangrama():
	var newTangram = get_tree().get_nodes_in_group("main")[0].tangram.instance()
	add_child(newTangram)
	
func cargar_pieza():
	var resultado = randi()%get_tree().get_nodes_in_group("main")[0].cant_figuras+1
	var newTangram
	match resultado:
		1:
			newTangram = get_tree().get_nodes_in_group("main")[0].gato.instance()
		2:
			newTangram = get_tree().get_nodes_in_group("main")[0].barco.instance()
		3:
			newTangram = get_tree().get_nodes_in_group("main")[0].casita.instance()
		4:
			newTangram = get_tree().get_nodes_in_group("main")[0].cisne.instance()
		5: 
			newTangram = get_tree().get_nodes_in_group("main")[0].arbol.instance()

	get_tree().get_nodes_in_group("tangram")[0].add_child(newTangram)