//*==========================| Direcciones |==========================
object arriba{
    method siguiente(posicion) = posicion.up(1)
    method anterior(posicion) = abajo.siguiente(posicion)
}

object abajo{
    method siguiente(posicion) = posicion.down(1)
    method anterior(posicion) = arriba.siguiente(posicion)
}

object derecha{
    method siguiente(posicion) = posicion.right(1)
    method anterior(posicion) = izquierda.siguiente(posicion)
}

object izquierda{
    method siguiente(posicion) = posicion.left(1)
    method anterior(posicion) = derecha.siguiente(posicion)
}

