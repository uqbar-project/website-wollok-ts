import objetos.*
import wollok.game.*

/*--INDICE--
  -Clase Texto
  -Obj Color

  -Instanciacion
  */

//----------------------------------------------------------Clase texto
class TextosInfo {
  const property texto
  const property color
  const property position 

  method text() = texto
  method textColor() = color
  method position() = position
}

//----------------------------------------------------------Color de textos
object color {
  const property blanco = "#ffffff"
  const property rojo = "#ff0000"
  const property amarillo = "#ffff00"
}

//----------------------------------------------------------OBJ textos
//--Items
const textoLlaveTerraza       = new TextosInfo(texto ="Hay algo dentro del vaso...
!!Encontraste la llave de la Terraza!!",color =color.blanco(), position = game.at(6,0))//Llave terraza

const textoFaltaEncendedor    = new TextosInfo(texto ="Todavía hay leña para quemar",color =color.blanco(), position = game.at(5,0))

const textoFaltaDisco         = new TextosInfo(texto ="Un tocadiscos antiguo.
Parece que aun funciona...",color =color.blanco(), position = game.at(5,0))

const textoFaltaEmblema       = new TextosInfo(texto ="Hay una ranura para encastrar algo...
Me parece conocida esta situación...",color =color.blanco(), position = game.at(5,0))

const textoFaltaNota1Telescop = new TextosInfo(texto ="Un viejo telescopio. 
No veo nada raro en el...",color =color.blanco(), position = game.at(5,0))

const textoFaltaNota2Cama     = new TextosInfo(texto ="Una cama llena de polvo.
Preferiría no tocarla...",color =color.blanco(), position = game.at(5,0))

const textoFaltaNota3Polvo    = new TextosInfo(texto ="Hay una nota con algo escrito pero...
No tiene ningún sentido...",color =color.blanco(), position = game.at(5,0))

const textoFaltaNota3PolvoP2  = new TextosInfo(texto ="Dentro del cajón hay frascos con distintos tipos de polvos. 
No hay nada importante...",color =color.blanco(), position = game.at(5,0))

const textoDisco = new TextosInfo(texto ="Una bolsa de basura. Espera, que es esto!
!!Encontraste un Disco de vinilo!!",color =color.blanco(), position = game.at(6,0))//Gema1

const textoLlaveMusica = new TextosInfo(texto ="Un estante con libr...Espera... que es esto?
!!Encontraste la llave de la Sala de Musica!!",color =color.blanco(), position = game.at(6,0))//Llave musica

const textoEncendedor = new TextosInfo(texto ="Hay algo dentro del cajon...
!!Encontraste un Encendedor!!",color =color.blanco(), position = game.at(6,0))//Encendedor

const textoEmblema = new TextosInfo(texto ="Al encender la chimenea un objeto se cayo.
!!Encontraste un Emblema!!",color =color.blanco(), position = game.at(6,0))//Emblema

const textoNota1 = new TextosInfo(texto ="Al usar el tocadiscos algo salió de el.
Nota:-El vigilante del cielo tiene un secreto-",color =color.blanco(), position = game.at(6,0))//Nota

const textoLlaveD = new TextosInfo(texto ="Usaste el emblema en el reloj.
!!Encontraste la llave del dormitorio!!",color =color.blanco(), position = game.at(6,0))//Llave Dormitorio

const textoLlaveC = new TextosInfo(texto ="Dentro del telescopio habia algo.
!!Encontraste la llave de la Cocina!!",color =color.blanco(), position = game.at(6,0))//Llave Dormitorio

const textoNota2 = new TextosInfo(texto ="Hay una NOTA dentro de la botella...
-Donde los sueños y pesadillas comienzan-",color =color.blanco(), position = game.at(6,0))//Encendedor

const textoLlaveSotano = new TextosInfo(texto ="Dentro de la almohada hay algo pesado...
!!Encontraste la llave del sotano!!",color =color.blanco(), position = game.at(6,0))//Encendedor

const textoNota3 = new TextosInfo(texto ="Hay una NOTA escrita aqui. -El P.lvo  
de Estr.l.as te ay.d.ra a des.cer la m..di.íon.-",color =color.blanco(), position = game.at(6,0))//Encendedor

const textoNota3P2 = new TextosInfo(texto ="La NOTA ahora tiene mas sentido. 
-Úsal. en l.s 5 a.t..chas en el o.den cor..cto-",color =color.blanco(), position = game.at(6,0))//Encendedor

const textoPolvoEstrellas = new TextosInfo(texto ="Este frasco contiene un polvo que brilla. 
!!Encontraste el Polvo de Estrellas!!",color =color.amarillo(), position = game.at(6,0))//Encendedor

const textoNadaImportante = new TextosInfo(texto ="No hay nada interesante aquí...",color =color.blanco(), position = game.at(5,0))
const textoHayAlgoPero    = new TextosInfo(texto ="Hay algo aqui pero...",color =color.blanco(), position = game.at(5,0))
const textoClavePolvo1    = new TextosInfo(texto ="El P.lvo de Estr.l.as te ay.d.ra a des.cer la m..di.íon.",color =color.blanco(), position = game.at(5,10))
const textoClavePolvo2    = new TextosInfo(texto ="Úsal. en l.s 5 a.t..chas en el o.den cor..cto",color =color.blanco(), position = game.at(5,10))

const textoNadaImportanteSilla = new TextosInfo(texto ="No me gusta esta silla, 
No es de mi estilo...",color =color.blanco(), position = game.at(5,0))

const textoEspejo           = new TextosInfo(texto ="En este espejo veo una persona 
detrás de mi...",color =color.blanco(), position = game.at(5,0))

const textoJarron           = new TextosInfo(texto ="Este jarrón está lleno de polvo...",color =color.blanco(), position = game.at(5,0))
const textoSillaRota        = new TextosInfo(texto ="Todas las sillas están por romperse...",color =color.blanco(), position = game.at(5,0))
const textoComida           = new TextosInfo(texto ="Esta comida no tiene buena pinta...",color =color.blanco(), position = game.at(5,0))
const textoRoto             = new TextosInfo(texto ="Aqui esta todo roto...",color =color.blanco(), position = game.at(5,0))
const textoCuadro           = new TextosInfo(texto ="Siento que la figura del cuadro me mira...",color =color.blanco(), position = game.at(5,0))
const textoPlanta           = new TextosInfo(texto ="Esta planta no la riegan hace años...",color =color.blanco(), position = game.at(5,0))
const textoPlanta2          = new TextosInfo(texto ="Esta planta esta casi marchita....",color =color.blanco(), position = game.at(5,0))
const textoReloj            = new TextosInfo(texto ="Este reloj esta yendo hacia atrás?!...",color =color.blanco(), position = game.at(5,0))

const textoClaveEspejo = new TextosInfo(texto ="Hay algo escrito aqui: 12, 9, 3, 7, 5. Sigue esa orden. 
Mi compañero que aun esta vivo será tu guía...¿?", color= color.blanco(),position=game.at(5, 0))

const textoClaveReloj = new TextosInfo(texto ="Un reloj que aun funciona...
Que raro no?...", color= color.blanco(),position=game.at(5, 0))

//ritual
const textoAntorchaOk = new TextosInfo(texto ="¡¡Al usar el polvo en la antorcha 
un humo de colores salio de ella!!",color =color.blanco(), position = game.at(5,0))

const textoAntorchaMal = new TextosInfo(texto ="¡¡No paso nada?!
Algo salio mal!!",color =color.blanco(), position = game.at(5,0))

const textoAntorchaSinPolvo = new TextosInfo(texto ="Es una Antorcha!...
¿Y que?",color =color.blanco(), position = game.at(5,0))

const textoMaldicionRota = new TextosInfo(texto ="La maldicion se rompio!!!
¡¡Arriba esta la salida!!!",color =color.blanco(), position = game.at(5,0))

const textoKatyCursed = new TextosInfo(texto ="Katy!? 
Como llegaste hasta aquí? Estas extraña... 
Por qué quieres ir hacia esa puerta? 
Parece que no queda otra opcion que avanzar...",color =color.blanco(), position = game.at(5,1)) 

const textoBiblioInfo1 = new TextosInfo(texto ="Un estante lleno de libros sobre un demonio que 
aprisiona a sus victimas para obtener sus almas...",color =color.blanco(), position = game.at(5,0))

const textoBiblioInfo2 = new TextosInfo(texto ="Un estante lleno con libros sobre 
posesiones demoniacas... Quien lee esto!?",color =color.blanco(), position = game.at(5,0))

const textoBiblioInfo3 = new TextosInfo(texto ="Un estante lleno de libros sobre sacrificios...
Esto no me gusta nada...",color =color.blanco(), position = game.at(5,0))

const textoBiblioInfo4 = new TextosInfo(texto ="Un estante lleno de libros sobre sectas religiosas...",color =color.blanco(), position = game.at(5,0))

const textoComentariosDeMas = new TextosInfo(texto ="Pff, este cuadro podría haberlo hecho yo!", color= color.blanco(),position=game.at(5, 0))

const textoPuertaSinUso = new TextosInfo(texto = "Esta puerta no se puede abrir...",color= color.blanco(),position=game.at(5, 0))

const textoCofreDormi = new TextosInfo(texto ="Un cofre!! Pero ya no hay nada adentro...",color =color.blanco(), position = game.at(5,0))

const textoArpa = new TextosInfo(texto ="cuando tenga plata, me compro un arpa",color =color.blanco(), position = game.at(5,0))


//----------------------------------------------------------Info de Items
const textoPuertaCerrada = new TextosInfo(texto ="La puerta está Cerrada. 
Necesito la llave.",color =color.blanco(), position = game.at(5,0))//para las puertas cerradas

const textoAgis = new TextosInfo(texto ="Te he estado esperando...
Veo que mi pequeño esclavo hizo su trabajo...
No te enojes con el, solo tome posesión de su ser para atraerte hasta aquí.
Ya no puedes salir de este lugar...
¡¡ENTREGAME TU ALMA!! 
¡YA NO PUEDES ESCAPÁR DE MI!",color =color.blanco(), position = game.at(5,7))

//textos gema
const textoGema = new TextosInfo(texto ="¡¡Que es esto!!
!!Encontraste una gema secreta!!",color =color.blanco(), position = game.at(6,0))//Encendedor

//ultimos textos
const textoLampara  = new TextosInfo(texto ="Una vieja lámpara.",color =color.blanco(), position = game.at(5,0))
const textoHeladera = new TextosInfo(texto ="Gracias al cielo esta vacia...",color =color.blanco(), position = game.at(5,0))
const textoCocina   = new TextosInfo(texto ="Una cocina sin gas.",color =color.blanco(), position = game.at(5,0))
const textoEstantes = new TextosInfo(texto ="No hay nada de valor aquí....",color =color.blanco(), position = game.at(5,0))//
const textoMesitas  = new TextosInfo(texto ="No hay nada útil en la mesa...",color =color.blanco(), position = game.at(5,0))

const textoTv       = new TextosInfo(texto ="Una vieja TV. Se puede ver un reflejo extraño en el...",color =color.blanco(), position = game.at(5,0))
const textoRadio    = new TextosInfo(texto ="Una vieja radio. Se puede escuchar una 
interferencia como si fuera ruido de lluvia…",color =color.blanco(), position = game.at(5,0))
const textoSofa     = new TextosInfo(texto ="Un sofá lleno de polvo.",color =color.blanco(), position = game.at(5,0))
const textoAlfombra = new TextosInfo(texto ="Una linda alfombra. No hay nada debajo de ella…",color =color.blanco(), position = game.at(5,0))
const textoPiano    = new TextosInfo(texto ="Siempre quise aprender a tocar el piano.",color =color.blanco(), position = game.at(5,0))

const textoOcarina  = new TextosInfo(texto ="Una Ocarina! Como la de Link!!",color =color.blanco(), position = game.at(5,0))
const textoViolin   = new TextosInfo(texto ="Ya no tiene cuerdas...",color =color.blanco(), position = game.at(5,0))
//const textoRadioMusic=new TextosInfo(texto ="Ya no tiene cuerdas...",color =color.blanco(), position = game.at(5,0))
const textoCuadro2  = new TextosInfo(texto ="Siento que alguien me observa...",color =color.blanco(), position = game.at(5,0))
const textoSikus    = new TextosInfo(texto ="Un Sikus… Cuando era chico tenia uno…",color =color.blanco(), position = game.at(5,0))

const textoPolvoPiso= new TextosInfo(texto ="Hay manchas de sangre aqui...creo...",color =color.blanco(), position = game.at(5,0))
const textoMuebles2 = new TextosInfo(texto ="Está lleno de ropa vieja.",color =color.blanco(), position = game.at(5,0))
const textoDerrumbe = new TextosInfo(texto ="Atrás se puede escuchar que 
la habitación se derrumba.",color =color.blanco(), position = game.at(5,0))


//----------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------Info de ubicacion
const ubicacionEntrada =       new TextosInfo(texto ="        Entrada",             color =color.blanco(), position = game.at(5,11))
const ubicacionComedor =       new TextosInfo(texto ="        El Comedor",          color =color.blanco(), position = game.at(5,11))
const ubicacionMusica =        new TextosInfo(texto ="        La Sala de Musica",   color =color.blanco(), position = game.at(5,11))
const ubicacionPrimerPiso =    new TextosInfo(texto ="        Primer Piso",         color =color.blanco(), position = game.at(5,11))
const ubicacionTerraza =       new TextosInfo(texto ="        La Terraza",          color =color.blanco(), position = game.at(5,11))
const ubicacionBiblioteca =    new TextosInfo(texto ="        La Biblioteca",       color =color.blanco(), position = game.at(5,11))
const ubicacionCocina =        new TextosInfo(texto ="        La Cocina",           color =color.blanco(), position = game.at(5,11))
const ubicacionDormitorio =    new TextosInfo(texto ="        El Dormitorio",       color =color.blanco(), position = game.at(5,11))
const ubicacionTunel =         new TextosInfo(texto ="        El Tunel Secreto",    color =color.blanco(), position = game.at(5,11))
const ubicacionRitual =        new TextosInfo(texto ="        La Sala del Ritual",  color =color.blanco(), position = game.at(5,11))
const ubicacionTunelSalida =   new TextosInfo(texto ="        Tunel de Escape",     color =color.blanco(), position = game.at(5,11))
const ubicacionJardinTrasero = new TextosInfo(texto ="        Jardin Trasero",      color =color.blanco(), position = game.at(5,11))
