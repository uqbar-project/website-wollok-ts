import wollok.game.*
import jugadores.*

class Digito{
	var property position
	const valor
	const tipo //"saldo" o "deuda"
	const jugador

	method image() = tipo + valor.ubicacion() + self.num() + ".png"
	
	method num() = (self.tipo() / valor.cantidad()).truncate(0).toString().takeRight(1)
	
	method tipo() = if (tipo=="saldo_") jugador.dinero() else jugador.deuda()
}

object millar{
	method cantidad() = 1000
	method ubicacion() = "millar_"
}
object centena{
	method cantidad() = 100
	method ubicacion() = "centena_"
}
object decena{
	method cantidad() = 10
	method ubicacion() = "decena_"
}
object unidad{
	method cantidad() = 1
	method ubicacion() = "unidad_"
}



class Balance{
	const unJugador
	const x = 5
    const y = unJugador.numero()+2
    var property position = game.at(x,y)
    const digitos = []
    
    method image() = "balance" + unJugador.numero().toString() + ".png"
    
    method addVisual(){

    	digitos.addAll([
	   		new Digito(tipo="saldo_",valor=unidad,jugador=unJugador,position=position),
	   		new Digito(tipo="saldo_",valor=decena,jugador=unJugador,position=position),
	   		new Digito(tipo="saldo_",valor=centena,jugador=unJugador,position=position),
	   		new Digito(tipo="saldo_",valor=millar,jugador=unJugador,position=position),
	   		
	   		new Digito(tipo="deuda_",valor=unidad,jugador=unJugador,position=position),
	   		new Digito(tipo="deuda_",valor=decena,jugador=unJugador,position=position),
	   		new Digito(tipo="deuda_",valor=centena,jugador=unJugador,position=position),
	   		new Digito(tipo="deuda_",valor=millar,jugador=unJugador,position=position)
    	])
    	digitos.forEach{d => game.addVisual(d)}
    	game.addVisual(self)
    }
    
    method digitos() = digitos    
}
