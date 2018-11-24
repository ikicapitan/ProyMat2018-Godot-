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
var p_resuelto = [pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new(), pieza.new()] #1 y 2 (TRI3), 3 (TRI2), 4 y 5 (TRI1), 6 QUAD, 7 RECT
var modificador = 1
var colores = [Color(1,1,0,1), Color(1,0,0,1), Color(0,1,0,1), Color(0, 0, 1, 1), Color(0, 1, 1, 1), Color(1, 0.65, 0, 1), Color(0.75, 0.75, 0.75)]
var res_generado = false


class pieza: #Clase pieza de Tangrama
	var pos_ini = Vector2(0,0)
	var disponible = false
	var grados = 0
	var vertices = []
	var flipped = false #Volteado
	var boton_select
	

func dibujar_figura(pieza, color):#Dibuja la pieza segun sus vertices
	draw_polygon(pieza.vertices, PoolColorArray([color]))
	
func calcular_centro(pieza):#Calcula un punto medio en la figura
	var centro = Vector2()
	for v in pieza.vertices:
		centro += v
	centro = centro / pieza.vertices.size() + v_offset
	return centro

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
		var c_color = colores[i]
		c_color.a = 0.2
		dibujar_figura(p_resuelto[i],c_color)
		for j in piezas[i].vertices.size():#Recorre los vertices de cada pieza para dibujar los contornos
			draw_line(piezas[i].vertices[j-1],piezas[i].vertices[j], Color(0,0,0,0.5), CONTORNO, false)
	update()
	
func actualizar():
	if(!res_generado):
		generar_figuras()
	if(target != -1): #Si el target es distin de -1, es porque se seleccionó una pieza
			for objeto in get_tree().get_nodes_in_group("slct"):#Elimino todos los vertices selecionables que existen
				remove_child(objeto)
				objeto.queue_free()
			for v in piezas[target].vertices: #Creamos vertices seleccionables segun el target
				var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
				newPoint.ref_v = v #Le doy como referencia el vertice actual
				newPoint.rect_position = v + v_offset
				add_child(newPoint)
	update()
	
	
func generar_figuras():
	tri3R()
	tri3A()
	tri1V()
	tri1C()
	tri2()
	quad1()
	rect1()
	if(!res_generado):
		generar_resuelto()
		
func generar_resuelto():
	for i in piezas.size():
		p_resuelto[i].pos_ini = piezas[i].pos_ini
		p_resuelto[i].vertices = piezas[i].vertices.duplicate()
		
	
	res_generado = true
	generar_desorden()
	
	for i in piezas.size():
		piezas[i].boton_select.rect_position = calcular_centro(piezas[i])
	
	update()
	
	
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
		
		piezas[5].boton_select.rect_position = calcular_centro(piezas[5])
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
		piezas[6].vertices.clear() #jJony
		piezas[6].vertices.append(Vector2(0,0).rotated(radianes) + pos_ini)
		piezas[6].vertices.append(Vector2(dim * offset.x * modificador,0).rotated(radianes) + pos_ini)
		piezas[6].vertices.append(Vector2(dim/2 * offset.x * modificador + dim * offset.x * modificador,dim/2 * -offset.x).rotated(radianes) + pos_ini)
		piezas[6].vertices.append(Vector2(dim/2 * offset.x * modificador,dim/2 * -offset.x).rotated(radianes) + pos_ini)
		
		piezas[6].boton_select.rect_position = calcular_centro(piezas[6])
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
		piezas[index].boton_select.rect_position = calcular_centro(piezas[index])
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

#Por Jjony	
func actualizar_figura():
	var vert_edit = get_tree().get_nodes_in_group("slct")#Obtengo todos los vertices editables que existen
	for i in piezas[target].vertices.size(): #Recorremos los vertices de la figura seleccionada  
		#Le asigno a cada vertice el valor del vertice seleccionable
		piezas[target].vertices[i] = Vector2(
		vert_edit[i].get_node("Ejes/X").text.to_int() * offset.x,
        - vert_edit[i].get_node("Ejes/Y").text.to_int() * offset.x)
        #Actualizo la posicion del vertice editable
		vert_edit[i].rect_position = piezas[target].vertices[i] + v_offset
        #Recalculo el centro
		piezas[target].boton_select.rect_position = calcular_centro(piezas[target])
		update()
	if check_win():#Me fijo si gano el jugador
		print("GANASTE!")
	else:
		print("VUELVE A INTENTARLO!")
		
func actualizar_seleccion():
	for objeto in get_tree().get_nodes_in_group("slct"):#Elimino todos los vertices selecionables que existen
		remove_child(objeto)
		objeto.queue_free()
	for v in piezas[target].vertices: #Creamos vertices seleccionables segun el target
		var newPoint = get_tree().get_nodes_in_group("main")[0].select.instance()
		newPoint.ref_v = v #Le doy como referencia el vertice actual
		newPoint.rect_position = v + v_offset
		add_child(newPoint)
		update()

func generar_desorden():
	for i in piezas.size():
		var resultado = randi()%10 #0 multiplica, 1 divide, 2 posicion, 3 modif 1 vert 
		match(resultado):
			0: #Mult
				for j in piezas[i].vertices.size():
					piezas[i].vertices[j] *= 1.5
			1: #Div
				for j in piezas[i].vertices.size():
					piezas[i].vertices[j] /= 1.5
			2: #Pos
				var desplazamiento = Vector2((randi()%20-10) * offset.x, (randi()%20-10) * offset.x)
				for j in piezas[i].vertices.size():
					piezas[i].vertices[j] += desplazamiento
			3: #Mod un vertice
				piezas[i].vertices[randi()%(piezas[i].vertices.size()-1)] = Vector2((randi()%20-10)*offset.x, (randi()%20-10)*offset.x)
			_:
				continue
	
func check_win():
	var coinciden = true
	
	for i in p_resuelto.size():#Recorre las piezas de tangrama por indice
		var k = 0
		#Recorre mientras cada vertice coincida con alguno del resuelto y no haya recorrido todos los vertices de la pieza
		while (coinciden && k < piezas[i].vertices.size()):
			coinciden = false#Se vuelve falso hasta encontrar coincidencia
			for l in piezas[i].vertices.size():#Recorre cada vertice de pieza i
				#print( "X:" + str(int(round(piezas[i].vertices[l].x / offset.x))) + " " + str(int(round(p_resuelto[i].vertices[k].x / offset.x))))
				#print( "Y:" + str(int(round(piezas[i].vertices[l].y / offset.x))) + " " + str(int(round(p_resuelto[i].vertices[k].y / offset.x))))
				
				#(OPCION 1)Coprueba que alguno de los vertices coicida con el vertice k del resuelto redondeando
#				if (int(round(piezas[i].vertices[l].x / offset.x)) == int(round(p_resuelto[i].vertices[k].x / offset.x)) &&
#				int(round(piezas[i].vertices[l].y / offset.x)) == int(round(p_resuelto[i].vertices[k].y) / offset.x)):
#					coinciden = true
					
				#(OPCION 2)Coprueba que alguno de los vertices coicida con el vertice k del resuelto con margen de error de offset.x / 2 (13px)
				if ( abs(piezas[i].vertices[l].x - p_resuelto[i].vertices[k].x) < offset.x / 2 &&
					abs(piezas[i].vertices[l].y - p_resuelto[i].vertices[k].y) < offset.x / 2):
					coinciden = true
				
				#OPCIONAL
				if l != k: #Si los indices son distintos
				#Compara que dos vertices de la misma pieza no esten en el mismo lugar
					if (int(round(piezas[i].vertices[l].x / offset.x)) == int(round(piezas[i].vertices[k].x / offset.x)) && 
					int(round(piezas[i].vertices[l].y / offset.x)) == int(round(piezas[i].vertices[k].y) / offset.x)):
						coinciden = false #Encontro una diferencia porque dos vertices no pueden ser iguales
				
			k += 1 #Paso al siguiente vertice del resuelto
			
#	print(coinciden)
	return coinciden #Retorna un booleano que indica si ganó
	
	

