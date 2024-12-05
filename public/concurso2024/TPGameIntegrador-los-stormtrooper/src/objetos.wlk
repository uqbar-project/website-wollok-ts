import barraItems.*
import personaje.*
import textos.*
//import wollok.game.*

/*--INDICE--
  -Clase Obj Invisibles
  -clase Obj que solo muestra mensaje
  -Clase Obj Visible que solo responde
  -Clase Obj que dan un item a cambio

  -Clase Item invisible
  -Clase Item que se recibe
  -Clase Item Visivble

  -Iconos
  -Iconos de Inventario
  -Limites de mapa
  -Obj Corazones
  -

  */

//----------------------------------------------------------------------------------------------------------Clase ObjetosInvisibles
class ObjetosInvisibles {
  var property position = game.center()
  //--enInventario(true)
  const property textoInfo
  method text() = textoInfo
  //const property image = "objBolsa.png" // solo para testing////////////////////////////////////////////
  
  //--elimina la visual y pasa al inventario
  method eliminar() {
    game.removeVisual(textoInfo)
  }
 
  //--reubica el obj al principio
  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)  
  }
}

//---------------------------------------------------------------------------------------------------------Clase Obj INVISIBLES que solo responden
class  ObjInvSoloResponde inherits ObjetosInvisibles {//solo muetra mensaje
  //var property position = game.center()
  //const property textoInfo
  //method text() = textoInfo
  //method eliminar() 
  //method ubicarEn(unaUbicacion) 
  const tiempo
  
  method interaccion() {
    game.sound("xfxFind.mp3").play()
    game.addVisual(textoInfo)//--muestra texto--
    game.schedule(tiempo, { => self.eliminar()})//--borra el texto
  }
}
//--Instanciaciones
          const objNadaImportante  = new ObjInvSoloResponde (textoInfo = textoNadaImportante, tiempo =1500)
          const objNadaImportante2 = new ObjInvSoloResponde (textoInfo = textoNadaImportante, tiempo =1500)
          const objNadaImportante3 = new ObjInvSoloResponde (textoInfo = textoNadaImportante, tiempo =1500)
          const objNadaImportante4 = new ObjInvSoloResponde (textoInfo = textoNadaImportante, tiempo =1500)
          const objClavePolvo1     = new ObjInvSoloResponde (textoInfo = textoClavePolvo1, tiempo =3000)
          const objClavePolvo2     = new ObjInvSoloResponde (textoInfo = textoClavePolvo2, tiempo =3000)
          const objNadaSilla       = new ObjInvSoloResponde (textoInfo = textoNadaImportanteSilla, tiempo =2000)
          const objComentariosDeMas= new ObjInvSoloResponde (textoInfo = textoComentariosDeMas, tiempo =2000)

          const objEspejo          = new ObjInvSoloResponde (textoInfo = textoEspejo, tiempo =2000)
          const objJarron          = new ObjInvSoloResponde (textoInfo = textoJarron, tiempo =2000)
          const objSillaRota       = new ObjInvSoloResponde (textoInfo = textoSillaRota, tiempo =2000)
          const objComida          = new ObjInvSoloResponde (textoInfo = textoComida, tiempo =2000)
          const objRoto            = new ObjInvSoloResponde (textoInfo = textoRoto, tiempo =2000)
          const objCuadro          = new ObjInvSoloResponde (textoInfo = textoCuadro, tiempo =2000)
          const objPlanta          = new ObjInvSoloResponde (textoInfo = textoPlanta, tiempo =2000)
          const objReloj           = new ObjInvSoloResponde (textoInfo = textoReloj, tiempo =2000)
          const objPuertaSinUso    = new ObjInvSoloResponde (textoInfo = textoPuertaSinUso, tiempo =2000)
          const objCofreDormi      = new ObjInvSoloResponde (textoInfo = textoCofreDormi, tiempo =2000)
          const objArpa            = new ObjInvSoloResponde (textoInfo = textoArpa, tiempo =2000)
  //--IMPORTANTES
          const objClaveEspejo     = new ObjInvSoloResponde (textoInfo = textoClaveEspejo, tiempo =3000)
          const objClaveReloj      = new ObjInvSoloResponde (textoInfo = textoClaveReloj, tiempo =3000)
          const objKatyCursed      = new ObjInvSoloResponde (textoInfo = textoKatyCursed, tiempo =6000)
          const objBiblioInfo1     = new ObjInvSoloResponde (textoInfo = textoBiblioInfo1, tiempo =3000)
          const objBiblioInfo2     = new ObjInvSoloResponde (textoInfo = textoBiblioInfo2, tiempo =3000)
          const objBiblioInfo3     = new ObjInvSoloResponde (textoInfo = textoBiblioInfo3, tiempo =3000)
          const objBiblioInfo4     = new ObjInvSoloResponde (textoInfo = textoBiblioInfo4, tiempo =3000)

  //textos para hacer
          const txtLamparas        = new ObjInvSoloResponde (textoInfo = textoLampara, tiempo =1500)
          const txtHeladera        = new ObjInvSoloResponde (textoInfo = textoHeladera, tiempo =1500)
          const txtCocina          = new ObjInvSoloResponde (textoInfo = textoCocina, tiempo =1500)
          const txtEstantes        = new ObjInvSoloResponde (textoInfo = textoEstantes, tiempo =1500)
          const txtMesitas         = new ObjInvSoloResponde (textoInfo = textoMesitas, tiempo =1500)
          
          const txtTv              = new ObjInvSoloResponde (textoInfo = textoTv, tiempo =1500)
          const txtRadio           = new ObjInvSoloResponde (textoInfo = textoRadio, tiempo =1500)
          const txtSofa            = new ObjInvSoloResponde (textoInfo = textoSofa, tiempo =1500)
          const txtAlfombra        = new ObjInvSoloResponde (textoInfo = textoAlfombra, tiempo =1500)
          const txtPiano           = new ObjInvSoloResponde (textoInfo = textoPiano, tiempo =1500)
          
          const txtViolin          = new ObjInvSoloResponde (textoInfo = textoViolin, tiempo =1500)
          const txtOcarina         = new ObjInvSoloResponde (textoInfo = textoOcarina, tiempo =1500)
          //const txtRadioMusic      = new ObjInvSoloResponde (textoInfo = textoNadaImportante, tiempo =1500)
          const txtCuadro2         = new ObjInvSoloResponde (textoInfo = textoCuadro2, tiempo =1500)
          const txtSikus           = new ObjInvSoloResponde (textoInfo = textoSikus, tiempo =1500)
          
          const txtPolvoPiso       = new ObjInvSoloResponde (textoInfo = textoPolvoPiso, tiempo =1500)
          const txtMuebles2        = new ObjInvSoloResponde (textoInfo = textoMuebles2, tiempo =1500)

          const txtDerrumbe        = new ObjInvSoloResponde (textoInfo = textoDerrumbe, tiempo =1500)
          


//---------------------------------------------------------------------------------------------------------Clase Obj VISIBLES que solo responden
/*
class ObjVisSoloResponde inherits ObjInvSoloResponde{
  const property image
}
//const prueba3 = new ObjVisSoloResponde (image = "life1Full.png", textoInfo = nadaImportante)//////////////////////////////////////////////////////////////////
*/
//---------------------------------------------------------------------------------------------------------Clase Items INVISIBLES 
class ItemInvisible {
  var property position = game.center()
  var property enInventario = false
  const property textoExplicacion
  const property iconDelItem
  const property itemInventario
  //var property loTengo = itemInventario.loTengo()

  method interaccion() {
    //texto
    game.addVisual(textoExplicacion)
    game.schedule(4000, { => game.removeVisual(textoExplicacion)})
    //icono item
    game.addVisual(iconDelItem)
    game.schedule(4000, { => game.removeVisual(iconDelItem)})
    //sonido
    game.sound("xfxItemGet2.mp3").play()
    
    self.enInventario(true)
    game.removeVisual(self)//cuando tomas el item,se borra
    
    //agrega el item al inventario
    barraItems.agregarAlaLista(itemInventario,self)
    barraItems.refreshListaDeItems()
  }

  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)  
  }
}
        const itemLlaveTerraza = new ItemInvisible(textoExplicacion = textoLlaveTerraza, iconDelItem = iconLlaveTerraza,itemInventario= iconLlaveTerrazaInv)
        const itemDisco        = new ItemInvisible(textoExplicacion = textoDisco, iconDelItem = iconDisco, itemInventario = iconDiscoInv)
        const itemLlaveMusica  = new ItemInvisible(textoExplicacion = textoLlaveMusica, iconDelItem = iconLlaveMusica, itemInventario = iconLlaveMInv)
        const itemEncendedor   = new ItemInvisible(textoExplicacion = textoEncendedor, iconDelItem = iconEncendedor, itemInventario = iconEncendedorInv)
        const itemNota2        = new ItemInvisible(textoExplicacion = textoNota2, iconDelItem = iconNota2, itemInventario = iconNota2Inv)
        const itemNota3        = new ItemInvisible(textoExplicacion = textoNota3, iconDelItem = iconNota3, itemInventario = iconNota3Inv)
        //gemas +
        const itemGema1        = new ItemInvisible(textoExplicacion = textoGema, iconDelItem = iconGema1, itemInventario = iconGema1Inv)
        const itemGema2        = new ItemInvisible(textoExplicacion = textoGema, iconDelItem = iconGema2, itemInventario = iconGema2Inv)
        const itemGema3        = new ItemInvisible(textoExplicacion = textoGema, iconDelItem = iconGema3, itemInventario = iconGema3Inv)
        const itemGema4        = new ItemInvisible(textoExplicacion = textoGema, iconDelItem = iconGema4, itemInventario = iconGema4Inv)
        const itemGema5        = new ItemInvisible(textoExplicacion = textoGema, iconDelItem = iconGema5, itemInventario = iconGema5Inv)
        const itemGema6        = new ItemInvisible(textoExplicacion = textoGema, iconDelItem = iconGema6, itemInventario = iconGema6Inv)
//

//------------------------------------------------------------------------Clase que da un Item a cambio de otro
class ItemQueSeRecibe {
  var property position = game.center()
  var property enInventario = false
  const property textoExplicacion
  const property iconDelItem
  const property itemInventario
  var property loTengo = itemInventario.loTengo()
  const property itemNecesario
  const property textoNoSePuede

  method interaccion() {
    if(!itemNecesario.enInventario()){//si no tenes el item 
      game.sound("xfxFind.mp3").play()
      game.addVisual(textoNoSePuede)//--muestra texto--
      game.schedule(2000, { => game.removeVisual(textoNoSePuede)})//--despues de 2s elimina el texto--
    }
    else if (itemNecesario.enInventario() && !self.enInventario()){//si lo tenes
      game.addVisual(textoExplicacion)//--muestra texto--
      game.schedule(4000, { => game.removeVisual(textoExplicacion)})//--despues de 2s elimina el texto--
      //sonido
      game.sound("xfxItemGet2.mp3").play()
      
      game.addVisual(iconDelItem)
      game.schedule(4000, { => game.removeVisual(iconDelItem)})

      self.enInventario(true)
      game.removeVisual(self)

      //agrega el item al inventario
      barraItems.agregarAlaLista(itemInventario, self)
      barraItems.refreshListaDeItems()
    }    
  }

  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)  
  }
}

const itemEmblema = 
  new ItemQueSeRecibe(
  textoExplicacion= textoEmblema, 
  iconDelItem= iconEmblema, 
  itemInventario= iconEmblemaInv,
  itemNecesario= itemEncendedor, 
  textoNoSePuede= textoFaltaEncendedor)

const itemNota1 = 
  new ItemQueSeRecibe(
  textoExplicacion= textoNota1, 
  iconDelItem= iconNota1, 
  itemInventario= iconNota1Inv,
  itemNecesario= itemDisco, 
  textoNoSePuede= textoFaltaDisco)

const itemLlaveDormi = 
  new ItemQueSeRecibe(
  textoExplicacion= textoLlaveD, 
  iconDelItem= iconLlaveD, 
  itemInventario= iconLlaveDInv,
  itemNecesario= itemEmblema, 
  textoNoSePuede= textoFaltaEmblema)

const itemLlaveCocina = 
  new ItemQueSeRecibe(
  textoExplicacion= textoLlaveC, 
  iconDelItem= iconLlaveC, 
  itemInventario= iconLlaveCInv,
  itemNecesario= itemNota1, 
  textoNoSePuede= textoFaltaNota1Telescop)

const itemLlaveSotano = 
  new ItemQueSeRecibe(
  textoExplicacion= textoLlaveSotano, 
  iconDelItem= iconLlaveSotano, 
  itemInventario= iconLlaveSotanoInv,
  itemNecesario= itemNota2, 
  textoNoSePuede= textoFaltaNota2Cama)

const itemNota3P2 = 
  new ItemQueSeRecibe(
  textoExplicacion= textoNota3P2, 
  iconDelItem= iconNota3P2, 
  itemInventario= iconNota3P2Inv,
  itemNecesario= itemNota3, 
  textoNoSePuede= textoFaltaNota3Polvo)

const itemPolvoEstrellas = 
  new ItemQueSeRecibe(
  textoExplicacion= textoPolvoEstrellas, 
  iconDelItem= iconPolvoEstrellas, 
  itemInventario= iconPolvoEstrellasInv,
  itemNecesario= itemNota3P2, 
  textoNoSePuede= textoFaltaNota3PolvoP2)

//-------------------------------------------------------------------------------------------------------Clase Items VISIBLES (que se eliminan de pantalla)
class ItemVisible {
  var property position = game.center()
  var property enInventario = false
  const property textoExplicacion
  const property iconDelItem
  const property image


  method interaccion() {
    game.addVisual(textoExplicacion)
    game.schedule(4000, { => game.removeVisual(textoExplicacion)})
      
    game.addVisual(iconDelItem)
    game.schedule(4000, { => game.removeVisual(iconDelItem)})
    self.enInventario(true)
    self.eliminar()
    //prueba inventorio
    //game.addVisual(iconLlave1Inv)
    //iconLlave1Inv.loTengo(true)
  
  }
  
  //--elimina la visual y pasa al inventario
  method eliminar() {
    game.removeVisual(self)
  }
 
  //--reubica el obj al principio
  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)  
  }
}
//const llave1 = new ItemVisible(textoExplicacion = textoLlave1, iconDelItem = iconLlaveTerraza, image = "key1.png")


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////--ICONOS--//////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//-----------------------------------------------------------------------------------------------OBJ Iconos de presentacion
class Iconos {
  const property image
  method position() = game.at(1,0)
}
        //primeros
        const iconLlaveTerraza   = new Iconos(image ="iconKey1.png")
        const iconLlaveMusica    = new Iconos(image ="iconKey3.png")

        //encendedor/emblema/llavedormi
        const iconEncendedor     = new Iconos(image ="iconEncendedorV2.png")
        const iconEmblema        = new Iconos(image ="iconShield.png")//no mobible
        const iconLlaveD         = new Iconos(image ="iconKey7.png")//no mobible
        
        //disco/telescopio/llavecocina
        const iconDisco          = new Iconos(image ="iconDisco.png")
        const iconNota1          = new Iconos(image ="iconNote1.png")//no mobible
        const iconLlaveC         = new Iconos(image ="iconKey6.png")//no mobible
        
        //nota1/cama/llavesotano
        const iconNota2          = new Iconos(image ="iconNote2.png")
        const iconLlaveSotano    = new Iconos(image ="iconKey5.png")//no mobible
        
        //polvo
        const iconNota3          = new Iconos(image ="iconNote3V1.png")
        const iconNota3P2        = new Iconos(image ="iconNote3.png")
        const iconPolvoEstrellas = new Iconos(image ="iconPolvo.png")

        //gemas icon +
        const iconGema1          = new Iconos(image ="itemGem_1.png")
        const iconGema2          = new Iconos(image ="itemGem_2.png")
        const iconGema3          = new Iconos(image ="itemGem_3.png")
        const iconGema4          = new Iconos(image ="itemGem_4.png")
        const iconGema5          = new Iconos(image ="itemGem_5.png")
        const iconGema6          = new Iconos(image ="itemGem_6.png")

//----------------------------------------------------------------------------------------Clase Iconos en el INVENTARIO
class IconoDeInventario {
  const property image 
  const property position 
  var property loTengo = false
}
        const iconLlaveTerrazaInv   = new IconoDeInventario(image= "iconKey2.png", position= game.at(11,10))
        const iconDiscoInv          = new IconoDeInventario(image= "iconDisco.png", position= game.at(11,9))
        const iconLlaveMInv         = new IconoDeInventario(image= "iconKey3.png", position= game.at(11,8))
        const iconEncendedorInv     = new IconoDeInventario(image= "iconEncendedorV2.png", position= game.at(11,7))
        const iconEmblemaInv        = new IconoDeInventario(image= "iconShield.png", position= game.at(11,6))
        const iconNota1Inv          = new IconoDeInventario(image= "iconNote1.png", position= game.at(11,5))
        const iconLlaveDInv         = new IconoDeInventario(image= "iconKey7.png", position= game.at(11,4))
        const iconLlaveCInv         = new IconoDeInventario(image= "iconKey6.png", position= game.at(11,3))
        const iconNota2Inv          = new IconoDeInventario(image= "iconNote2.png", position= game.at(11,2))
        const iconLlaveSotanoInv    = new IconoDeInventario(image= "iconKey5.png", position= game.at(11,2))
        const iconNota3Inv          = new IconoDeInventario(image= "iconNote3V1.png", position= game.at(11,1))
        const iconNota3P2Inv        = new IconoDeInventario(image= "iconNote3.png", position= game.at(11,1))
        const iconPolvoEstrellasInv = new IconoDeInventario(image= "iconPolvo.png", position= game.at(11,1))
        
        // gemas icon inventario +
        const iconGema1Inv = new IconoDeInventario(image= "itemGem_1.png", position= game.at(0,1))
        const iconGema2Inv = new IconoDeInventario(image= "itemGem_2.png", position= game.at(0,2))
        const iconGema3Inv = new IconoDeInventario(image= "itemGem_3.png", position= game.at(0,3))
        const iconGema4Inv = new IconoDeInventario(image= "itemGem_4.png", position= game.at(0,4))
        const iconGema5Inv = new IconoDeInventario(image= "itemGem_5.png", position= game.at(0,5))
        const iconGema6Inv = new IconoDeInventario(image= "itemGem_6.png", position= game.at(0,6))

//---------------------------------------------------------------------------Bordes del tablero
class Tope {
  var property position = game.origin()

  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)  
  }
}
        const topeAbajo  = new Tope()
        const topeArriba = new Tope()
        const topeIzq    = new Tope()
        const topeDer    = new Tope()

//--------------------------------------------------------------------------corazones de vida
object corazon1 {
  const property image = "life1Full.png"
  const property position = game.at(0,10)
}
object corazon2 {
  const property image = "life1Full.png"
  const property position = game.at(0,9)
}
object corazon3 {
  const property image = "life1Full.png"
  const property position = game.at(0,8)
}
object corazon4 {
  const property image = "life1Full.png"
  const property position = game.at(0,7)
}