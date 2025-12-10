import obstaculos.*
import wollok.game.*
import clientes.*
import partida.*
import pedidos.*
import personaje.*
import menus.*

class Nivel {
    // variables iniciales del Player
    const property posxPlayer = 7
    const property posyPlayer = 9
    const property vidaNivel = 10
    const property dineroNivel = 10000

    const obstaculos = []

    const vehiculos = []

    const transparentes = []

    const clientes = []

    const pedidos = []
    
    method obstaculos() = obstaculos

    method vehiculos() = vehiculos

    method transparentes() = transparentes

    method clientes() = clientes

    method imagenMenuPausa()

    method renderizarObjetos(){
        self.cargarListasDeObjetos()
        obstaculos.forEach({ o => game.addVisual(o) })
        pedidos.forEach({ p => game.addVisual(p) })
        clientes.forEach({ c => game.addVisual(c) })
        vehiculos.forEach({ v => game.addVisual(v) })
        transparentes.forEach({ t => game.addVisual(t) })
    }

    method cargarListasDeObjetos()

    method removerObjetos() {
        obstaculos.forEach({ o => game.removeVisual(o) })
        vehiculos.forEach({ v => game.removeVisual(v) })
        transparentes.forEach({ t => game.removeVisual(t) })
        pedidos.forEach({ p => game.removeVisual(p) })
        clientes.forEach({ c => game.removeVisual(c) })

        obstaculos.clear()
        vehiculos.clear()
        transparentes.clear()
        pedidos.clear()
        clientes.clear()
    }

    method sincronizarPedidosConClientes() {
        pedidos.forEach({p => p.sincronizarPedidoConCliente(clientes.find({ c => c.pedido() == p}))})
    }

    method setDinInicial(jugador){
        jugador.setDin(dineroNivel)
    }

    method cumpleLosPedidosEntregados(pedidosEntregados) {
      return pedidosEntregados == pedidos.size()
    }

    method vehiculoDelNivel()

    method tickVehiculos()


}

class Nivel1 inherits Nivel {

    override method cargarListasDeObjetos() {

        const transito1 = new Gorrudo(position = game.at(17,6), image = "transito_dev.png")
        const chorro = new Chorro(position = game.at(6,6), image = "rocho_dev.png", arma=pipa)

        const bondi = new Vehiculo(position = game.at(8,2), image = "bondi_dev.png", peso=3500)
        const taxi = new Vehiculo(position = game.at(4,1), image = "taxi_dev.png", peso=1500)
        const patrullero = new Vehiculo(position = game.at(13,1), image = "patrullero_dev5.png", peso=1500)
        
        const obsInvisible1 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = taxi)
        const obsInvisible2 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = bondi)
        const obsInvisible3 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = obsInvisible2)
        const obsInvisible4 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = patrullero)
        
        const cajitaFeliz = new Pedido(position = zonaPedidos.mcdonalds(), nombre = "CAJITA FELIZ", image = "pedido_cajitafeliz.png", ganancia=1000)
        const guaymallen = new Pedido(position = zonaPedidos.kiosco(), nombre = "GUAYMALLEN",image = "pedido_guaymallen.png", ganancia=500)
        const pedidoverdu = new Pedido(position = zonaPedidos.mercado(), nombre = "PEDIDO DE VERDULERIA",image = "pedido_verdu.png", ganancia=300)

        const cliente1 = new Cliente(position = zonaClientes.edificioDerechaSup(), image = "cliente1_dev.png", avatar = "cliente1_avatar.png", propina = 1, mensaje = "Porfin loco, tardaste mucho!", pedido=cajitaFeliz, movimiento=false)
        const cliente2 = new Cliente(position = zonaClientes.edificioAvenida3(), image = "cliente2_dev.png", avatar = "cliente2_avatar.png", propina = 1, mensaje = "Gracias genio, toma esta propina", pedido=guaymallen, movimiento=false)
        const cliente3 = new Cliente(position = zonaClientes.edificioAvenida5(), image = "cliente3_dev.png", avatar = "cliente3_avatar.png", propina = 1, mensaje = "Hasta luego joven", pedido=pedidoverdu,movimiento=false)

        vehiculos.addAll([bondi,taxi,patrullero])
        transparentes.addAll([obsInvisible1,obsInvisible2,obsInvisible3,obsInvisible4])
        obstaculos.addAll([transito1,chorro])
        pedidos.addAll([cajitaFeliz,guaymallen,pedidoverdu])
        clientes.addAll([cliente1,cliente2,cliente3])
    }

    override method imagenMenuPausa() = "imagen_pausa_nivel1.png"

    override method vehiculoDelNivel() = pie

    override method tickVehiculos() = 1500
}

class Nivel2 inherits Nivel {

    method position() = game.origin()

    method image() = "transicion_nivel2.png"

    override method cargarListasDeObjetos() {

        const transito1 = new Gorrudo(position = game.at(13,6), image = "transito_dev.png")
        const chorro = new Chorro(position = game.at(24,7), image = "rocho_dev.png", arma=pipa)
        const motochorro = new Chorro(position = game.at(5,10), image = "motochorrodoble_dev.png", arma=pipa)
        const bache1 = new Gorrudo(position = game.at(5,6), image = "bache_dev.png", mensaje = "Mira por donde vas", movimiento=false)

        const bondi = new Vehiculo(position = game.at(8,2), image = "bondi_dev.png", peso=3500)
        const taxi = new Vehiculo(position = game.at(4,1), image = "taxi_dev.png", peso=1500)
        const patrullero = new Vehiculo(position = game.at(13,1), image = "patrullero_dev5.png", peso=1500)
        const mercadoLibre = new Vehiculo(position = game.at(18,2), image = "camioneta_dev1.png", peso=3500)
        
        const obsInvisible1 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = taxi)
        const obsInvisible2 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = bondi)
        const obsInvisible3 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = obsInvisible2)
        const obsInvisible4 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = patrullero)
        const obsInvisible5 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = mercadoLibre)
        
        const cajitaFeliz = new Pedido(position = zonaPedidos.mcdonalds(), nombre = "CAJITA FELIZ", image = "pedido_cajitafeliz.png", ganancia=1000)
        const guaymallen = new Pedido(position = zonaPedidos.kiosco(), nombre = "GUAYMALLEN",image = "pedido_guaymallen.png", ganancia=500)
        const pedidoverdu = new Pedido(position = zonaPedidos.mercado(), nombre = "PEDIDO DE VERDULERIA",image = "pedido_verdu.png", ganancia=300)
        const pedidopanaderia= new Pedido(position = zonaPedidos.mercado2(), nombre = "PEDIDO DE PANADERIA",image = "pedido_panaderia.png", ganancia=800)

        const cliente1 = new Cliente(position = zonaClientes.edificioDerechaSup(), image = "cliente1_dev.png", avatar = "cliente1_avatar.png", propina = 1, mensaje = "Porfin loco, tardaste mucho!", pedido=cajitaFeliz)
        const cliente2 = new Cliente(position = zonaClientes.edificioAvenida3(), image = "cliente2_dev.png", avatar = "cliente2_avatar.png", propina = 1, mensaje = "Gracias genio, toma esta propina", pedido=guaymallen)
        const cliente3 = new Cliente(position = zonaClientes.edificioAvenida5(), image = "cliente3_dev.png", avatar = "cliente3_avatar.png", propina = 1, mensaje = "Hasta luego joven", pedido=pedidoverdu)
        const cliente4 = new Cliente(position = zonaClientes.plaza1(), image = "cliente4_dev.png", avatar = "cliente4_avatar.png", propina = 0, mensaje = "No te dejo propina", pedido=pedidopanaderia)

        vehiculos.addAll([bondi,taxi,patrullero,mercadoLibre])
        transparentes.addAll([obsInvisible1,obsInvisible2,obsInvisible3,obsInvisible4,obsInvisible5])
        obstaculos.addAll([transito1,chorro,motochorro,bache1])
        pedidos.addAll([cajitaFeliz,guaymallen,pedidoverdu,pedidopanaderia])
        clientes.addAll([cliente1,cliente2,cliente3,cliente4])
    }

    override method imagenMenuPausa() = "imagen_pausa_nivel2.png"

    override method vehiculoDelNivel() = bici

    override method tickVehiculos() = 1000
}

class Nivel3 inherits Nivel {

    method position() = game.origin()

    method image() = "transicion_nivel3.png"

    override method cargarListasDeObjetos() {

        const transito1 = new Gorrudo(position = game.at(13,6), image = "transito_dev.png")
        const chorro = new Chorro(position = game.at(24,7), image = "rocho_dev.png", arma=pipa)
        const motochorro = new Chorro(position = game.at(5,10), image = "motochorrodoble_dev.png", arma=pipa)
        const motochorro2 = new Chorro(position = game.at(17,10), image = "motochorrodoble_dev.png", arma=pipa)
        const bache1 = new Gorrudo(position = game.at(5,6), image = "bache_dev.png", mensaje = "Mira por donde vas", movimiento=false)
        const bache2 = new Gorrudo(position = game.at(28,13), image = "bache_dev.png", mensaje = "Mira por donde vas", movimiento=false)
        const piquetero1 = new Gorrudo(position = game.at(13,3), image = "npc_piquete_dev.png", movimiento=false)
        const piquetero2 = new Gorrudo(position = game.at(16,3), image = "npc_piedra_dev.png", movimiento=false)

        const bondi = new Vehiculo(position = game.at(8,2), image = "bondi_dev.png", peso=3500)
        const taxi = new Vehiculo(position = game.at(4,1), image = "taxi_dev.png", peso=1500)
        const patrullero = new Vehiculo(position = game.at(13,1), image = "patrullero_dev5.png", peso=1500)
        const mercadoLibre = new Vehiculo(position = game.at(18,2), image = "camioneta_dev1.png", peso=3500)
        const escolar = new Vehiculo(position = game.at(23,2), image = "escolar_dev.png", peso=4000)
        
        const obsInvisible1 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = taxi)
        const obsInvisible2 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = bondi)
        const obsInvisible3 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = obsInvisible2)
        const obsInvisible4 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = patrullero)
        const obsInvisible5 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = mercadoLibre)
        const obsInvisible6 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = escolar)
        const obsInvisible7 = new Transparente(obstaculoPadre = true, nombreObstaculoPadre = obsInvisible6)
        
        const cajitaFeliz = new Pedido(position = zonaPedidos.mcdonalds(), nombre = "CAJITA FELIZ", image = "pedido_cajitafeliz.png", ganancia=1000)
        const guaymallen = new Pedido(position = zonaPedidos.kiosco(), nombre = "GUAYMALLEN",image = "pedido_guaymallen.png", ganancia=500)
        const pedidoverdu = new Pedido(position = zonaPedidos.mercado(), nombre = "PEDIDO DE VERDULERIA",image = "pedido_verdu.png", ganancia=300)
        const pedidopanaderia= new Pedido(position = zonaPedidos.mercado2(), nombre = "PEDIDO DE PANADERIA",image = "pedido_panaderia.png", ganancia=800)
        const pedidoespecial= new Pedido(position = zonaPedidos.kiosco2(), nombre = "PEDIDO ESPECIAL",image = "pedido_especial.png", ganancia=5000)

        const cliente1 = new Cliente(position = zonaClientes.edificioDerechaSup(), image = "cliente1_dev.png", avatar = "cliente1_avatar.png", propina = 1, mensaje = "Porfin loco, tardaste mucho!", pedido=cajitaFeliz)
        const cliente2 = new Cliente(position = zonaClientes.edificioAvenida3(), image = "cliente2_dev.png", avatar = "cliente2_avatar.png", propina = 1, mensaje = "Gracias genio, toma esta propina", pedido=guaymallen)
        const cliente3 = new Cliente(position = zonaClientes.edificioAvenida5(), image = "cliente3_dev.png", avatar = "cliente3_avatar.png", propina = 1, mensaje = "Hasta luego joven", pedido=pedidoverdu)
        const cliente4 = new Cliente(position = zonaClientes.plaza1(), image = "cliente4_dev.png", avatar = "cliente4_avatar.png", propina = 0, mensaje = "No te dejo propina", pedido=pedidopanaderia)
        const cliente5 = new Cliente(position = zonaClientes.obelisco1(), image = "cliente_especial_dev.png",avatar = "cliente_especial_avatar.png", propina = 1000, mensaje = "SAPEEEEEE!!!!", pedido=pedidoespecial, movimiento=false)

        vehiculos.addAll([bondi,taxi,patrullero,mercadoLibre,escolar])
        transparentes.addAll([obsInvisible1,obsInvisible2,obsInvisible3,obsInvisible4,obsInvisible5,obsInvisible6,obsInvisible7])
        obstaculos.addAll([transito1,chorro,motochorro,bache1,bache2,piquetero1,piquetero2,motochorro2])
        pedidos.addAll([cajitaFeliz,guaymallen,pedidoverdu, pedidopanaderia,pedidoespecial])
        clientes.addAll([cliente1,cliente2,cliente3,cliente4,cliente5])
    }

    override method imagenMenuPausa() = "imagen_pausa_nivel3.png"

    override method vehiculoDelNivel() = moto

    override method tickVehiculos() = 800
}


class FinDelJuego inherits Nivel {

    method position() = game.origin()

    method image() = "pantalla_win.png"

    override method imagenMenuPausa() {}

    override method renderizarObjetos() {}

    override method cargarListasDeObjetos() {}

    override method vehiculoDelNivel() {}

    override method tickVehiculos() {}
}