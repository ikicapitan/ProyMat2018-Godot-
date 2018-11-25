extends Node

#Datos globales del proyecto
var tiempo = 0 #Tiempo restante
var puntos = 0 #Puntos

func _ready():
	pass

func clock(): #Paso 1 segundo
	tiempo -= 1
	if(tiempo == 0): #Si se termino el tiempo
		time_up()
		
func time_up(): #Se acabo el tiempo
	set_puntos(-5)
	get_tree().reload_current_scene()
	
func set_puntos(var add_puntos):
	puntos += add_puntos
	get_tree().get_nodes_in_group("puntos")[0].text = str(puntos)