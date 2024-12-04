import _07_personaje.*
import wollok.game.*
import _03_frames.*

class Animacion inherits Objeto{
	var property escenas
	var property indice = 0
	const property tiempo = 200
}

class AnimacionCaminar inherits Animacion{
    method cambiarImagen() {
        image = escenas.get(indice)
        indice = (indice + 1) % escenas.size()
    }
}

class CascarudoCaminando inherits AnimacionCaminar(escenas =["cascarudo/Cascarudo_Caminar_1-176x176.png", "cascarudo/Cascarudo_Caminar_2-176x176.png" ]){}
class HombreRobotCaminando inherits AnimacionCaminar(escenas =["hombresRobots/Hombre_Robot_Caminar_1-272x192.png", "hombresRobots/Hombre_Robot_Caminar_2-272x192.png", "hombresRobots/Hombre_Robot_Caminar_3-272x192.png", "hombresRobots/Hombre_Robot_Caminar_4-272x192.png"]){}

class AnimacionMuerte inherits Animacion {
	var property nombreTick
	
	method mostrar() { 
		game.onTick(tiempo, nombreTick, {
			if (indice < escenas.size()) {
				image = escenas.get(indice)
				indice +=1
			} else { game.removeTickEvent(nombreTick) game.removeVisual(self)}
		})
	}
}

class MuerteCascarudo inherits AnimacionMuerte(
	escenas = 
	 [ "cascarudo/Cascarudo_Morir_0-176x176.png",
	   "cascarudo/Cascarudo_Morir_1-176x176.png",
	   "cascarudo/Cascarudo_Morir_2-176x176.png",
	   "cascarudo/Cascarudo_Morir_3-176x176.png" ]){
}
class MuerteHombreRobot inherits AnimacionMuerte(
	escenas = 
		   	[ "hombresRobots/Hombre_Robot_Morir_1-272x192.png",
		   	  "hombresRobots/Hombre_Robot_Morir_2-272x192.png",
		   	  "hombresRobots/Hombre_Robot_Morir_3-272x192.png", 
		   	  "hombresRobots/Hombre_Robot_Morir_4-272x192.png",
		   	  "hombresRobots/Hombre_Robot_Morir_5-272x192.png",
		   	  "hombresRobots/Hombre_Robot_Morir_6-272x192.png",
		   	  "hombresRobots/Hombre_Robot_Morir_7-272x192.png" ] ){
}
class MuerteJuan inherits AnimacionMuerte(
	escenas =  
        ["juanSalvo/Jugador_Muerte_1-260x192.png",
        "juanSalvo/Jugador_Muerte_2-260x192.png",
        "juanSalvo/Jugador_Muerte_3-260x192.png",
        "juanSalvo/Jugador_Muerte_4-260x192.png"
    ]){
}