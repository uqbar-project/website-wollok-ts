import src.elementos.*
import salida.*
import colisiones.*



object productorDeEscenas{
  var property objetos = []
  method renderizarEsquinas(){
    game.addVisual(esquinaInfIzq)
    game.addVisual(esquinaInfDer)
    game.addVisual(esquinaSupIzq)
    game.addVisual(esquinaSupDer)

    colisiones.agregarObstaculo(esquinaInfIzq)
    colisiones.agregarObstaculo(esquinaInfDer)
    colisiones.agregarObstaculo(esquinaSupIzq)
    colisiones.agregarObstaculo(esquinaSupDer)
  }


  method renderizarVertical(posX,pared,rango){ //izq o der
      rango.forEach({posY=>
          const pared_nuevo=pared.generar()
          pared_nuevo.position(game.at(posX,posY))
          game.addVisual(pared_nuevo)
          colisiones.agregarObstaculo(pared_nuevo)
      })
  }
  method renderizarHorizontal(posY,pared,rango){ //up o down
      rango.forEach({posX=>
        const pared_nuevo=pared.generar()
        pared_nuevo.position(game.at(posX,posY))
        game.addVisual(pared_nuevo)
        colisiones.agregarObstaculo(pared_nuevo)
      })
  }

  
  method renderizarCon(salida,lado,destino_,ubicacionPersonaje){ //emergencia/final/comun - izqDerSupInf - renderiza salida y el costado
    const imgs=salida.get(lado)
    const posiciones=lado.posiciones()
    const s1 = new Salida(image=imgs.first(),position=posiciones.first(),destino=destino_,ubicacion=ubicacionPersonaje, esObstaculo = false)
    const s2 = new Salida(image=imgs.last(),position=posiciones.last(),destino=destino_,ubicacion=ubicacionPersonaje, esObstaculo = false)
    //new Obstaculo(image=imgs.first(),position=posiciones.first())
    //const s2 = new Obstaculo(image=imgs.last(),position=posiciones.last())
    game.addVisual(s1)
    game.addVisual(s2)
    

    s1.analizarCambioSector()
    s2.analizarCambioSector()
    lado.renderizar(self)

  }
 
}





