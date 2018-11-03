extends Node2D

#Por jJony
const BASE = 3.0
var CONTORNO = 2.0
var LADO_TRI_G = BASE * 2
var LADO_TRI_M = sqrt(BASE * BASE + BASE * BASE) # CALCULANDO HIPOTENUSA
var LADO_TRI_C = BASE
var LADO_PARAL = BASE
var LADO_CUADR = LADO_TRI_M / 2 # MITAD DE LADO_TRI_M

#Por Iki
var offset
export (Vector2) var v_offset
var piezas = [pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new()] #1 y 2 (TRI3), 3 (TRI2), 4 y 5 (TRI1), 6 QUAD, 7 RECT
var modificador = 1

class pieza: #Clase pieza de Tangrama
	var pos_ini = Vector2(0,0)
	var disponible = false
	var grados = 0
	var vertices = []
	var flipped = false #Volteado

func _ready():
	offset = get_tree().get_nodes_in_group("nivel")[0].dim_offset
	
func _draw():
	dibujar_tangrama()
	
func dibujar_tangrama():
	for i in piezas.size():
		for j in piezas[i].vertices.size():
			draw_line(piezas[i].vertices[j-1],piezas[i].vertices[j], Color(0,0,0,0.5), CONTORNO, false)
	tri3R()
	tri3A()
	tri1V()
	tri1C()
	tri2()
	quad1()
	rect1()
	
func actualizar():
	update()
	
func quad(var dim, var color): #Dibuja cuadrado
	if(piezas[5].disponible):
		if(piezas[5].flipped): #Si esta volteada
			modificador = -1
		else:
			modificador = 1
		var radianes = deg2rad(piezas[5].grados)
		piezas[5].pos_ini = Vector2(piezas[5].pos_ini.x * offset.x, piezas[5].pos_ini.y * offset.x)
		piezas[5].vertices.append(Vector2(0,0).rotated(radianes) + piezas[5].pos_ini)
		piezas[5].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes)+ piezas[5].pos_ini)
		piezas[5].vertices.append(Vector2(dim * offset.x * modificador,dim * -offset.x).rotated(radianes)+ piezas[5].pos_ini)
		piezas[5].vertices.append(Vector2(0,dim * -offset.x).rotated(radianes)+ piezas[5].pos_ini)
		draw_polygon(piezas[5].vertices, PoolColorArray([color]))
	
func rect(var dim, var color): #Dibuja rectangulo
	if(piezas[6].disponible):
		if(piezas[6].flipped): #Si esta volteada
			modificador = -1
		else:
			modificador = 1
	if(piezas[6].disponible):
		var radianes = deg2rad(piezas[6].grados)
		piezas[6].pos_ini = Vector2(piezas[6].pos_ini.x * offset.x, piezas[6].pos_ini.y * offset.x)
		piezas[6].vertices.append(Vector2(0,0).rotated(radianes) + piezas[6].pos_ini)
		piezas[6].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes)+ piezas[6].pos_ini)
		piezas[6].vertices.append(Vector2(dim/2 * offset.x * modificador + dim * offset.x * modificador,dim/2 * -offset.x).rotated(radianes)+ piezas[6].pos_ini)
		piezas[6].vertices.append(Vector2(dim/2 * offset.x * modificador,dim/2 * -offset.x).rotated(radianes)+ piezas[6].pos_ini)
		draw_polygon(piezas[6].vertices, PoolColorArray([color]))
	
func tri(var dim, var color, var index): #Dibuja triangulos dinamicos
	if(piezas[index].disponible):
		if(piezas[index].flipped): #Si esta volteada
			modificador = -1
		else:
			modificador = 1
	if(piezas[index].disponible):
		var radianes = deg2rad(piezas[index].grados)
		piezas[index].pos_ini = Vector2(piezas[index].pos_ini.x * offset.x, piezas[index].pos_ini.y * offset.x)
		piezas[index].vertices.append(Vector2(0,0).rotated(radianes) + piezas[index].pos_ini)
		piezas[index].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes) + piezas[index].pos_ini)
		piezas[index].vertices.append(Vector2(dim/2 * offset.x * modificador, dim/2 * -offset.x).rotated(radianes)+ piezas[index].pos_ini)
		draw_polygon(piezas[index].vertices, PoolColorArray([color]))	
	
	if(index == 2): #Si es el triangulo mediano le genero vertices seleccionables
		for v in piezas[index].vertices: 
			var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
			add_child(newPoint)
			newPoint.rect_position = v + v_offset
			
		

#Sub Funciones

func tri1V(): #Dibuja un triangulo pequeño
	tri(LADO_TRI_C, Color(0, 1, 1, 1), 4) #Triangulo mas chico
	
func tri1C(): #Dibuja un triangulo pequeño
	tri(LADO_TRI_C, Color(0, 0, 1, 1), 3) #Triangulo mas chico
	
func tri2():
	tri(LADO_TRI_M, Color(0,1,0,1), 2) #Triangulo mediano
	
func tri3R():
	tri(LADO_TRI_G, Color(1,0,0,1), 1) #Triangulo mayor
	
func tri3A():
	tri(LADO_TRI_G, Color(1,1,0,1), 0) #Triangulo mayor
	
func quad1(): #Dibuja el cuadrado
	quad(LADO_CUADR, Color(1, 0.65, 0, 1))

func rect1(): #Dibuja el rectangulo
	rect(LADO_PARAL, Color(0.75, 0.75, 0.75, 1))
	

	