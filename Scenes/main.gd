extends Node

export (PackedScene) var txt_cartes #Txt para ejes cartesianos
export (PackedScene) var tangram #Tangrama
export (PackedScene) var gato
export (PackedScene) var barco
export (PackedScene) var casita
export (PackedScene) var cisne
export (PackedScene) var arbol
export (PackedScene) var select
export (PackedScene) var select_p
export (int) var cant_figuras
export (int) var tiempo_desafio

func _ready():
	randomize()
	gamehandler.tiempo = tiempo_desafio
	var minutos = gamehandler.tiempo / 60 #Divido los segundos para mostrar minutos
	var segundos = gamehandler.tiempo % 60 #Obtengo el resto de division para mostrar segundos
	get_tree().get_nodes_in_group("reloj")[0].text = (str(minutos) + ":" + str(segundos)) #Convierto a string los resultados para mostrar
	get_tree().get_nodes_in_group("puntos")[0].text = str(gamehandler.puntos)


func _on_clock_timeout(): #Cada vez que transcurre 1 segundo
	gamehandler.clock()
	var minutos = gamehandler.tiempo / 60 #Divido los segundos para mostrar minutos
	var segundos = gamehandler.tiempo % 60 #Obtengo el resto de division para mostrar segundos
	get_tree().get_nodes_in_group("reloj")[0].text = (str(minutos) + ":" + str(segundos)) #Convierto a string los resultados para mostrar
