extends Node2D

#Por jJony
const BASE = 3.0
var CONTORNO = 2.0
var LADO_TRI_G = BASE * 2
var LADO_TRI_M = sqrt(BASE * BASE + BASE * BASE) # CALCULANDO HIPOTENUSA
var LADO_TRI_C = BASE
var LADO_PARAL = BASE
var LADO_CUADR = LADO_TRI_M / 2 # MITAD DE LADO_TRI_M
var target = -1 #Pieza seleccionada actualmente

#Por Iki
var offset
export (Vector2) var v_offset
var piezas = [pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new()] #1 y 2 (TRI3), 3 (TRI2), 4 y 5 (TRI1), 6 QUAD, 7 RECT
var modificador = 1
var colores = [Color(1,1,0,1), Color(1,0,0,1), Color(0,1,0,1), Color(0, 0, 1, 1), Color(0, 1, 1, 1), Color(1, 0.65, 0, 1), Color(0.75, 0.75, 0.75)]

class pieza: #Clase pieza de Tangrama
	var pos_ini = Vector2(0,0)
	var disponible = false
	var grados = 0
	var vertices = []
	var flipped = false #Volteado
	var boton_select

func dibujar_figura(pieza, color):#Dibuja la pieza segun sus vertices
	draw_polygon(pieza.vertices, PoolColorArray([color]))

func _ready():
	offset = get_tree().get_nodes_in_group("nivel")[0].dim_offset
	for p in piezas:#Recorre las piezas del tangrama
		p.boton_select = get_tree().get_nodes_in_group("main")[0].select_p.instance()
		p.boton_select.modulate = Color(1, 0.41, 0.71, 1)
		add_child(p.boton_select)
	
	
func _draw():
	dibujar_tangrama()
	
func dibujar_tangrama():
	for i in piezas.size():#Recorre las piezas del tangrama por indice
		dibujar_figura(piezas[i],colores[i])
		for j in piezas[i].vertices.size():#Recorre los vertices de cada pieza para dibujar los contornos
			draw_line(piezas[i].vertices[j-1],piezas[i].vertices[j], Color(0,0,0,0.5), CONTORNO, false)
	update()
	
func actualizar():
	generar_figuras()
	if(target != -1): #Si el target es distin de -1, es porque se seleccionó una pieza
			for objeto in get_tree().get_nodes_in_group("slct"):#Elimino todos los vertices selecionables que existen
				remove_child(objeto)
				objeto.queue_free()
			for v in piezas[target].vertices: #Creamos vertices seleccionables segun el target
				var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
				add_child(newPoint)
				newPoint.rect_position = v + v_offset
	update()
	
func generar_figuras():
	tri3R()
	tri3A()
	tri1V()
	tri1C()
	tri2()
	quad1()
	rect1()
	
func quad(var dim): #Crea cuadrado
	if(piezas[5].disponible):
		if(piezas[5].flipped): #Si esta volteada
			modificador = -1
		else:
			modificador = 1
		var radianes = deg2rad(piezas[5].grados)
		var pos_ini = Vector2(piezas[5].pos_ini.x * offset.x, piezas[5].pos_ini.y * offset.x)
		piezas[5].vertices.clear()
		piezas[5].vertices.append(Vector2(0,0).rotated(radianes) + pos_ini)
		piezas[5].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes)+ pos_ini)
		piezas[5].vertices.append(Vector2(dim * offset.x * modificador,dim * -offset.x).rotated(radianes)+ pos_ini)
		piezas[5].vertices.append(Vector2(0,dim * -offset.x).rotated(radianes)+ pos_ini)
#
#		if(target == 5): #Si el target es identico a 5, es porque es esta pieza
#			for v in piezas[5].vertices: #Creamos vertices seleccionables
#				var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
#				add_child(newPoint)
#				newPoint.rect_position = v + v_offset
		#Crear punto seleccion figura
#		var newPoint = get_tree().get_nodes_in_group("main")[0].select_p.instance()
#		add_child(newPoint)
#		piezas[5].boton_select.modulate = Color(1, 0.41, 0.71, 1)
		var max_point = piezas[5].vertices[0]
		var min_point = piezas[5].vertices[0]
		for i in piezas[5].vertices.size() -1:
			max_point.x = max(max_point.x,piezas[5].vertices[i+1].x)
			max_point.y = min(max_point.y,piezas[5].vertices[i+1].y)
			min_point.x = min(min_point.x,piezas[5].vertices[i+1].x)
			min_point.y = max(min_point.y,piezas[5].vertices[i+1].y)
		
		piezas[5].boton_select.rect_position = (max_point + min_point ) /2 + v_offset
		piezas[5].boton_select.pieza_referencia = 5
	
func rect(var dim): #Crea rectangulo
	if(piezas[6].disponible):
		if(piezas[6].flipped): #Si esta volteada
			modificador = -1
		else:
			modificador = 1
	if(piezas[6].disponible):
		var radianes = deg2rad(piezas[6].grados)
		var pos_ini = Vector2(piezas[6].pos_ini.x * offset.x, piezas[6].pos_ini.y * offset.x)
		piezas[6].vertices.clear()
		piezas[6].vertices.append(Vector2(0,0).rotated(radianes) + pos_ini)
		piezas[6].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes) + pos_ini)
		piezas[6].vertices.append(Vector2(dim/2 * offset.x * modificador + dim * offset.x * modificador,dim/2 * -offset.x).rotated(radianes) + pos_ini)
		piezas[6].vertices.append(Vector2(dim/2 * offset.x * modificador,dim/2 * -offset.x).rotated(radianes) + pos_ini)
#		draw_polygon(piezas[6].vertices, PoolColorArray([color]))
#		if(target == 6):
#			for v in piezas[6].vertices: 
#				var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
#				add_child(newPoint)
#				newPoint.rect_position = v + v_offset
		#Crear punto seleccion figura
#		var newPoint = get_tree().get_nodes_in_group("main")[0].select_p.instance()
#		add_child(newPoint)
#		piezas[6].boton_select.modulate = Color(1, 0.41, 0.71, 1)
		var max_point = piezas[6].vertices[0]
		var min_point = piezas[6].vertices[0]
		for i in piezas[5].vertices.size() -1:
			max_point.x = max(max_point.x,piezas[6].vertices[i+1].x)
			max_point.y = min(max_point.y,piezas[6].vertices[i+1].y)
			min_point.x = min(min_point.x,piezas[6].vertices[i+1].x)
			min_point.y = max(min_point.y,piezas[6].vertices[i+1].y)
		
		piezas[6].boton_select.rect_position = (max_point + min_point ) /2 + v_offset
		piezas[6].boton_select.pieza_referencia = 6
	
	
func tri(var dim, var index): #Crea triangulos dinamicos
	if(piezas[index].disponible):
		if(piezas[index].flipped): #Si esta volteada
			modificador = -1
		else:
			modificador = 1
	if(piezas[index].disponible):
		var radianes = deg2rad(piezas[index].grados)
		var pos_ini = Vector2(piezas[index].pos_ini.x * offset.x, piezas[index].pos_ini.y * offset.x)
		piezas[index].vertices.clear()
		piezas[index].vertices.append(Vector2(0,0).rotated(radianes) + pos_ini)
		piezas[index].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes) + pos_ini)
		piezas[index].vertices.append(Vector2(dim/2 * offset.x * modificador, dim/2 * -offset.x).rotated(radianes) + pos_ini)
#		draw_polygon(piezas[index].vertices, PoolColorArray([color]))	
#		if(target == index):
#			for v in piezas[index].vertices: 
#				var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
#				add_child(newPoint)
#				newPoint.rect_position = v + v_offset
#
		#Crear punto seleccion figura
#		var newPoint = get_tree().get_nodes_in_group("main")[0].select_p.instance()
#		add_child(newPoint)
#		piezas[index].boton_select.modulate = Color(1, 0.41, 0.71, 1)
		piezas[index].boton_select.rect_position = ((piezas[index].vertices[0] + piezas[index].vertices[1] + piezas[index].vertices[2])) /3 + v_offset
		piezas[index].boton_select.pieza_referencia = index

#Sub Funciones

func tri1V(): #Dibuja un triangulo pequeño
	tri(LADO_TRI_C, 4) #Triangulo mas chico
	
func tri1C(): #Dibuja un triangulo pequeño
	tri(LADO_TRI_C, 3) #Triangulo mas chico
	
func tri2():
	tri(LADO_TRI_M, 2) #Triangulo mediano
	
func tri3R():
	tri(LADO_TRI_G, 1) #Triangulo mayor
	
func tri3A():
	tri(LADO_TRI_G, 0) #Triangulo mayor
	
func quad1(): #Dibuja el cuadrado
	quad(LADO_CUADR)

func rect1(): #Dibuja el rectangulo
	rect(LADO_PARAL)
	

	