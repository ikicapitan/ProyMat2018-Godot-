extends Node2D

var offset

func _ready():
	offset = get_tree().get_nodes_in_group("nivel")[0].dim_offset
	
func _draw():
	tri3R(180,Vector2(8,0))
	tri3A(90,Vector2(0,0))
	tri1V(0, Vector2(2,6))
	tri1C(270, Vector2(8,4))
	tri2(135, Vector2(8,4))
	quad1(315, Vector2(6,6))
	rect1(0,Vector2(0,8))
	
func quad(var dim, var color, var grados, var pos_ini): #Dibuja cuadrado
	var radianes = deg2rad(grados)
	var lista_i = [] #Lista de puntos a conectar
	pos_ini = Vector2(pos_ini.x * offset.x, pos_ini.y * offset.x)
	lista_i.append(Vector2(0,0).rotated(radianes) + pos_ini)
	lista_i.append(Vector2(dim * offset.x,0).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(dim * offset.x,dim * -offset.x).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(0,dim * -offset.x).rotated(radianes)+ pos_ini)
	draw_polygon(lista_i, PoolColorArray([color]))
	
func rect(var dim, var color, var grados, var pos_ini): #Dibuja rectangulo
	var radianes = deg2rad(grados)
	var lista_i = [] #Lista de puntos a conectar
	pos_ini = Vector2(pos_ini.x * offset.x, pos_ini.y * offset.x)
	lista_i.append(Vector2(0,0).rotated(radianes) + pos_ini)
	lista_i.append(Vector2(dim * offset.x,0).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(dim/2 * offset.x + dim * offset.x,dim/2 * -offset.x).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(dim/2 * offset.x,dim/2 * -offset.x).rotated(radianes)+ pos_ini)
	draw_polygon(lista_i, PoolColorArray([color]))
	
func tri(var dim, var color, var grados, var pos_ini): #Dibuja triangulos dinamicos
	var radianes = deg2rad(grados)
	var lista_i = [] #Lista de puntos a conectar
	pos_ini = Vector2(pos_ini.x * offset.x, pos_ini.y * offset.x)
	lista_i.append(Vector2(0,0).rotated(radianes) + pos_ini)
	lista_i.append(Vector2(dim * offset.x,0).rotated(radianes)+ pos_ini)
	lista_i.append(Vector2(dim/2 * offset.x,dim/2 * -offset.x).rotated(radianes)+ pos_ini)
	draw_polygon(lista_i, PoolColorArray([color]))	

#Sub Funciones

func tri1V(var grados, var posicion): #Dibuja un triangulo pequeño
	tri(4, Color(0, 1, 1, 1), grados, posicion) #Triangulo mas chico
	
func tri1C(var grados, var posicion): #Dibuja un triangulo pequeño
	tri(4, Color(0, 0, 1, 1), grados, posicion) #Triangulo mas chico
	
func tri2(var grados, var posicion):
	tri(6, Color(0,1,0,1), grados, posicion) #Triangulo mediano
	
func tri3R(var grados, var pos):
	tri(8, Color(1,0,0,1), grados, pos) #Triangulo mayor
	
func tri3A(var grados, var pos):
	tri(8, Color(1,1,0,1), grados, pos) #Triangulo mayor
	
func quad1(var grados, var pos): #Dibuja el cuadrado
	quad(3, Color(1, 0.65, 0, 1), grados, pos)

func rect1(var grados, var pos): #Dibuja el rectangulo
	rect(4, Color(0.75, 0.75, 0.75, 1), grados, pos)
	