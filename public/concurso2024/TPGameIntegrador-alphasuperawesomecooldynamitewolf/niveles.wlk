//import TPGameIntegrador-alphasuperawesomecooldynamitewolf.menu.*
import enemigos.*
import juegoBase.*
import castillo.*
import wollok.game.*
import pantalla.* 
import menu.*
import armas.*
import controles.*

class Nivel{
    const property enemigos = []
    const property enemigosReys = []
    const nivel // identificador -nivel
    const enemigosPorOleada 
    const musica
    const dificultad
    var enemigosGenerados =0
    var enemigosVivos=0                 //x,y
    const cantidadDeRey=1
    var reysGenerados=0
    var partidaSigue=true //sirve para las oleadas, ayuda a datenerlas
    const ubicacionesPosiblesDeTorre=[[8,3],[11,0],[11,3],[16,0],[14,4],[16,6]] //debe estar ordenada //[8,3] es tomado como game.at()
    const ubicacionesCamino = [] //Camino por donde pasan los enemigos
    const ubicacionActualJugador=[]
    const pantalla   //pasar la imagen de clase Pantalla al crear el nivel.
    //const fondoNivelActual ==> Aca declaramos la imagen del fondo al instanciar el nivel. Y lo pasamos como parametro como game.boardGround(fondoNivelActual)
    // Inicializa el nivel
    method eliminarEnemigos(){
        enemigos.forEach({ e => e.eliminar()}) //elimina sus visuales.
        enemigosReys.forEach({ e => e.eliminar()})
    } 
    method partidaSigue() =partidaSigue      
    method iniciar(){
        enemigosGenerados =0
        reysGenerados=0
        partidaSigue=true
        pantalla.iniciar()
        enemigosVivos=enemigosPorOleada
        game.addVisual(personajePrincipal)
        game.schedule(2000, {self.generarOleada()})
        game.addVisual(castillo)     
        self.agregarContadores()      
        castillo.activarColision()
        game.boardGround("fondo.png") //Al ser clase, y reutilizarlo para los nivles habría que pasar la imagen del boarGround como parametro de alguna constante que la declaramos al instanciar el New Nivel

    }
    method agregarContadores() {
        if(!game.hasVisual(contadorEnemigos) && !game.hasVisual(contadorMoneda) && !game.hasVisual(contadorVida)){
            game.addVisual(contadorVida)           
            game.addVisual(contadorEnemigos)           
            game.addVisual(contadorMoneda)     
        }
    }
    method iniciarMusica(){
        musica.play()
        musica.shouldLoop(true)
    }
    method detenerMusica(){
        musica.stop()
    }
    method partidaFinalizada(){
        self.eliminarEnemigos();
        game.removeVisual(personajePrincipal)
        personajePrincipal.partidaFinalizada()
        game.removeVisual(castillo)
        partidaSigue= false
    }
    //a cada enemigo se le agrega a su lista de posiciones todas las posiciones posibles
    method mapeoEnemigo() {
        const soloEnemigo=[]
        soloEnemigo.addAll(ubicacionesCamino) // evitar errores por paso de referencia.
        return soloEnemigo
    } 

    //ubicaciones actuales tanto cursor como de las torres
    method ubicacionActualJugador() =ubicacionActualJugador 
    method ubicacionesPosibles() =ubicacionesPosiblesDeTorre 
    //Posiciones de las torres, cursor
    method ubicacionSiguienteA(pos) {
        if(ubicacionActualJugador.size() !=ubicacionesPosiblesDeTorre.size()-1){
            ubicacionActualJugador.add(pos)
            return self.restaDeUbicaciones().get(0)
        }
        else{
            return self.reiniciarSiguientesUbi()
        }
        

    } 

    method reiniciarSiguientesUbi() {
        ubicacionActualJugador.clear()
        return self.obtenerPrimeraDireccion() //entrega la primera direccion al jugador porque las posiciones se reiniciaron.
    }
    method obtenerPrimeraDireccion() =ubicacionesPosiblesDeTorre.get(0) 
    method reiniciarAnterioresUbi() {
        ubicacionActualJugador.addAll(ubicacionesPosiblesDeTorre)
        return self.ubicacionAnterior()
    }
    method obtenerUltimo() =ubicacionActualJugador.last()
    method ubicacionAnterior() {
        if(ubicacionActualJugador.size() >0){
            const moverse=self.obtenerUltimo()
            ubicacionActualJugador.remove(self.obtenerUltimo())
            return  moverse
        }
        else{
            return self.reiniciarAnterioresUbi()
        }
    }
    method restaDeUbicaciones() =ubicacionesPosiblesDeTorre.filter({u => not self.ubicacionActualJugador().any({ub=> ub ==u})}) //filtra por los que NO estan en las lista de la lista de posiciones del jugador
    //Metodo encargado de generar la oleada de enemigos
    method generarOleada(){
            game.removeTickEvent("oleada orco")
            game.onTick(4400, "oleada orco", {
            if(partidaSigue and  (enemigosGenerados < enemigosPorOleada )){
            console.println("generé un orco")
            enemigosGenerados += 1
            enemigosVivos += 1
            const orco =new Orco(vida=1+(dificultad*5),daño=10,imagen="idleTroll.png",imagenIdle="idleTroll.png",imagenRun="runTroll.png",imagenDaño="idleTrollDaño.png",nivelAct=self,posiciones=self.mapeoEnemigo()) //Imagino que esto es para las pruebas. Pero podríamos parametrizar los stats (no todos, algunos), para poder cambiar de nivel a nivel.
            enemigos.add(orco)
            game.addVisual(orco)
            orco.iniciar()
            self.generarOleada()
            }else{
                self.generarRey()
            } 
        })
        }

    method generarRey() {
        if(partidaSigue and reysGenerados<cantidadDeRey ){
            reysGenerados+=1
            const orcoRey =new OrcoRey(vida=5* (dificultad*10),daño=15,imagen="idleTrollMiniBoss.png",imagenIdle="idleTrollMiniBoss.png",imagenRun="runTrollMiniBoss.png",imagenDaño="idleTrollMiniBossDaño.png",nivelAct=self,posiciones=self.mapeoEnemigo())
            enemigos.add(orcoRey)
            enemigosReys.add(orcoRey) 
            game.addVisual(orcoRey)
            orcoRey.iniciar()
        }
                
    } 
    method vicotoriaSeLogro(){ //esto lo llama el orco rey al morir.
        if(!enemigosReys.isEmpty() and enemigosReys.all({e => !e.estaVivo()})){/// Ningun rey añadido a la lista de orcos reyes, deben de estar vivos.
            juegoDelCastillo.ganarPartida()
        }
    }
}


///usos, se podria utilizar para saber cuantas torres hay para ubicar,  si es que en algun nivel especifico ya no se permite dicha torre etc.
///Contadores
const contadorVida = new ContadorVida()
const contadorMoneda = new ContadorMoneda()
const contadorEnemigos = new ContadorEnemigos()

//---------(Entorno)--------
const nivelUnoFondo=new Pantalla(imagen="nivel1FondoPixel.png")
const nivelDosFondo=new Pantalla(imagen="nivel2Fondo.png")
const nivelPrueba = new Nivel(musica=game.sound("menu2.mp3"),nivel=0,enemigosPorOleada=10, dificultad=0,ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
const nivel1= new Nivel(musica=game.sound("orcsAttacking.mp3"),nivel=1, dificultad =1,enemigosPorOleada=6, ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
const nivel2= new Nivel(musica=game.sound("coldOrcs.mp3"),nivel=2,dificultad =2, enemigosPorOleada=8, cantidadDeRey=3,ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelDosFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante
const nivel3= new Nivel(musica=game.sound("orcsLastPush.mp3"),nivel=3, dificultad =3,enemigosPorOleada=10,  cantidadDeRey =5 ,ubicacionesCamino = [[19,5],[18,5],[17,5],[16,4],[16,3],[16,2],[15,2],[14,2],[13,2],[12,2],[11,2],[10,2],[9,2],[8,2],[8,1],[8,0]],pantalla=nivelUnoFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante

//const nivel2= new Nivel(musica=game.sound("coldOrcs.mp3"),nivel=2,dificultad =2, enemigosPorOleada=6, cantidadDeRey=2,ubicacionesCamino = [[19,5],[18,5],[17,5],[17,6],[16,6],[15,6],[14,6],[13,6],[12,6],[11,6],[11,5],[11,4],[11,3],[11,2],[11,1],[11,0]],pantalla=nivelDosFondo) //un nivel para probar diseños. --cambiar a tutorial mas adelante