import protagonista.*
import objetos1.*
import nivelDos.*
import nivelDosDificil.*

object sistema{
    //// variables para el nivel facil y difficil
    const property antorchas = [
    new Antorcha(position = game.at(1,10.3)),
    new Antorcha(position = game.at(2,10.3)),
    new Antorcha(position = game.at(3,10.3)),
    new Antorcha(position = game.at(4,10.3)),
    new Antorcha(position = game.at(11,10.3)),
    new Antorcha(position = game.at(12,10.3)),
    new Antorcha(position = game.at(13,10.3)),
    new Antorcha(position = game.at(14,10.3))]

    const property pistas = [
    new Pistas(nota = nota1 , position = game.at(5, 1) , img = "libroPista.png"),
    new Pistas(nota = nota2 , position = game.at(17.5, 7) , img = "signoV2.png"),
    new Pistas(nota = nota3 , position = game.at(7, 9.5) , img = "wollokcuadro.png")
    ]

    const property pistasDificiles = [
      new Pistas(nota = nota4 , position = game.at(5, 1),img = "libroPista.png"),
      new Pistas(nota = nota5 , position = game.at(7, 9.5) , img = "dioses.png")]

    const property antorchasMulticolor = [
      new AntorchaMulticolor(position = game.at(1,10.3)),
      new AntorchaMulticolor(position = game.at(2,10.3)),
      new AntorchaMulticolor(position = game.at(3,10.3)),
      new AntorchaMulticolor(position = game.at(4,10.3)),
      new AntorchaMulticolor(position = game.at(11,10.3)),
      new AntorchaMulticolor(position = game.at(12,10.3)),
      new AntorchaMulticolor(position = game.at(13,10.3)),
      new AntorchaMulticolor(position = game.at(14,10.3))]

    const property llaveNivel1 = new Llave()
    const property puerta = new Puerta(position = game.at(16, 10), puertaA = "puertaUnoAbierta.png" , puertaC = "puertaUnoCerrada.png" , llaveNecesaria = llaveNivel1 , llevaA = nivel2)
    const property puertaD = new Puerta(position = game.at(16, 10), puertaA = "puertaUnoAbierta.png" , puertaC = "puertaUnoCerrada.png" , llaveNecesaria = llaveNivel1 , llevaA = nivel2Dificil)
    const property cofre = new Cofre(position = game.at(18, 1.5), contenido = llaveNivel1, decir = "recogiste la llave de la puerta")
    const property nota1 = new Nota( img = "notaDelLibro.png", tiempoEnPantalla= 5000)
    const property nota2 = new Nota( img = "notaCuadroSignoPregunta.png", tiempoEnPantalla= 5000)
    const property nota3 = new Nota( img = "notaDelCuadro.png", tiempoEnPantalla= 5000)
    const property nota4 = new Nota( img = "acerD.png", tiempoEnPantalla= 15000)
    const property nota5 = new Nota( img = "lista1D.png", tiempoEnPantalla= 15000)

    const property elementos = [puerta,puertaD,cofre]


    method reiniciar() {
      elementos.forEach({elemento=>elemento.reiniciar()})
      antorchas.forEach({antorcha => antorcha.reiniciar()})
      carlitos.reiniciar()
      antorchasMulticolor.forEach({antorcha => antorcha.reiniciar()})
     }
    method iniciarCofre() = cofre.iniciar()
    method iniciarPuerta() = puerta.iniciar()
    method iniciarPuertaD() = puertaD.iniciar()
    method iniciarAntorchas() = antorchas.forEach({antorcha => antorcha.iniciar()})
    method iniciarPista() = pistas.forEach({pistas => pistas.iniciar()})
    method iniciarAntorchasNivelDificil() = antorchasMulticolor.forEach({antorcha => antorcha.iniciar()})
    method iniciarPistaDificil() = pistasDificiles.forEach({pistas => pistas.iniciar()})

    method mapearAntorchas() = antorchas.map({antorcha => antorcha.estaPrendida()})
    method cumplePatron() = self.mapearAntorchas() == [true,true,false,true,true,false,true,true] 
    method mapearAntorchasMulticolor() = antorchasMulticolor.map({antorcha => antorcha.contador()})
    method cumplePatronDificil() = self.mapearAntorchasMulticolor() == [6,0,4,1,7,2,5,3]

    method aparecerLLave() {
      if(self.cumplePatron()){ // aca creo que quedaria mejor un or con (self.cumplePatronDificil())
        game.addVisual(new Llave(position = game.center(),img = "llave.png"))
      }
    }

    method aparecerLlaveD() {
      if(self.cumplePatronDificil()){
        game.addVisual(new Llave(position = game.center(),img = "llave.png"))
      }
    }
   
}