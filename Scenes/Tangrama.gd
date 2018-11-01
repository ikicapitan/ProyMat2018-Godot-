extends Node2D

var offset

const BASE = 3.0
var SEPARADOR = BASE / 4
var CONTORNO = 2.0
var LADO_TRI_G = BASE * 2
var LADO_TRI_M = sqrt(BASE * BASE + BASE * BASE) # CALCULANDO HIPOTENUSA
var LADO_TRI_C = BASE
var LADO_PARAL = BASE
var LADO_CUADR = LADO_TRI_M / 2 # MITAD DE LADO_TRI_M

func _ready():
	offset = get_tree().get_nodes_in_group("nivel")[0].dim_offset
	
func voltear_x(lista_i):
	for i in lista_i.size():
		lista_i[i].x = (lista_i[i].x * -1)
		
func voltear_y(lista_i):
	for i in lista_i.size():
		lista_i[i].y = (lista_i[i].y * -1)
	
func _draw():
	cat()
	
func tangrama():
	tri3R(180,Vector2(LADO_TRI_G,0))
	tri3A(90,Vector2(0,0))
	tri1V(0, Vector2(LADO_TRI_C/2, LADO_TRI_G/2 + LADO_TRI_C/2))
	tri1C(270, Vector2(LADO_TRI_G,LADO_TRI_C))
	tri2(135, Vector2(LADO_TRI_G,LADO_TRI_C))
	quad1(315, Vector2(LADO_TRI_G/2 + LADO_TRI_C/2, LADO_TRI_G/2 + LADO_TRI_C/2))
	rect1(0,Vector2(0, LADO_TRI_G))
	
func cat():
	tri3R(135,Vector2(0,-LADO_TRI_M))
	tri3A(90,Vector2(-LADO_TRI_C,-LADO_TRI_C -LADO_TRI_M))
	tri1V(90, Vector2(-LADO_TRI_C*1.5,-LADO_TRI_C*2.5  -LADO_TRI_M))
	tri1C(-90, Vector2(-LADO_TRI_C/2,-LADO_TRI_C*1.5 -LADO_TRI_M))
	tri2(270, Vector2(-LADO_TRI_C,-LADO_TRI_C))
	quad1(-45, Vector2(-LADO_TRI_C,-LADO_TRI_C -LADO_TRI_M))
	rect1(-5,Vector2(0, 0))
	
func quad(var dim, var color, var grados, var pos_ini): #Dibuja cuadrado
	var radianes = deg2rad(grados)
	
	var lista_i = [] #Lista de puntos a conectar
	pos_ini = Vector2(pos_ini.x * offset.x, pos_ini.y * offset.x)
	lista_i.append(Vector2(0,0).rotated(radianes) + pos_ini)
	lista_i.append(Vector2(dim * offset.x,0).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(dim * offset.x,dim * -offset.x).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(0,dim * -offset.x).rotated(radianes)+ pos_ini)
	draw_polygon(lista_i, PoolColorArray([color]))
	for i in lista_i.size():
		draw_line(lista_i[i-1], lista_i[i], Color(0,0,0,1), CONTORNO, false)
	
func rect(var dim, var color, var grados, var pos_ini): #Dibuja rectangulo
	var radianes = deg2rad(grados)
	var lista_i = [] #Lista de puntos a conectar
	pos_ini = Vector2(pos_ini.x * offset.x, pos_ini.y * offset.x)
	lista_i.append(Vector2(0,0).rotated(radianes))
	lista_i.append(Vector2(dim * offset.x,0).rotated(radianes))
	lista_i.append(Vector2(dim/2 * offset.x + dim * offset.x,dim/2 * -offset.x).rotated(radianes))
	lista_i.append(Vector2(dim/2 * offset.x,dim/2 * -offset.x).rotated(radianes))
	draw_polygon(lista_i, PoolColorArray([color]))
	for i in lista_i.size():
		draw_line(lista_i[i-1],lista_i[i], Color(0,0,0,1), CONTORNO, false)
	
func tri(var dim, var color, var grados, var pos_ini): #Dibuja triangulos dinamicos
	var radianes = deg2rad(grados)
	var lista_i = [] #Lista de puntos a conectar
	pos_ini = Vector2(pos_ini.x * offset.x, pos_ini.y * offset.x)
	lista_i.append(Vector2(0,0).rotated(radianes) + pos_ini)
	lista_i.append(Vector2(dim * offset.x,0).rotated(radianes) + pos_ini)
	lista_i.append(Vector2(dim/2 * offset.x, dim/2 * -offset.x).rotated(radianes)+ pos_ini)
	lista_i.append(lista_i[0])
#	for i in lista_i.size():
#		lista_i[i] = Vector2(lista_i[i].x, lista_i[i].y * (-1))
	draw_polygon(lista_i, PoolColorArray([color]))
	for i in lista_i.size():
		draw_line(lista_i[i-1],lista_i[i], Color(0,0,0,1), CONTORNO, false)

#Sub Funciones

func tri1V(var grados, var posicion): #Dibuja un triangulo pequeño
	tri(LADO_TRI_C, Color(1, 1, 1, 1), grados, posicion) #Triangulo mas chico
	
func tri1C(var grados, var posicion): #Dibuja un triangulo pequeño
	tri(LADO_TRI_C, Color(1, 1, 1, 1), grados, posicion) #Triangulo mas chico
	
func tri2(var grados, var posicion):
	tri(LADO_TRI_M, Color(1,1,1,1), grados, posicion) #Triangulo mediano
	
func tri3R(var grados, var pos):
	tri(LADO_TRI_G, Color(1,1,1,1), grados, pos) #Triangulo mayor
	
func tri3A(var grados, var pos):
	tri(LADO_TRI_G, Color(1,1,1,1), grados, pos) #Triangulo mayor
	
func quad1(var grados, var pos): #Dibuja el cuadrado
	quad(LADO_CUADR, Color(1, 1, 1, 1), grados, pos)

func rect1(var grados, var pos): #Dibuja el rectangulo
	rect(LADO_PARAL, Color(1, 1, 1, 1), grados, pos)
	