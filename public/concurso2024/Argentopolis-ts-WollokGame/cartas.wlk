import wollok.game.*
import juego.*
import pantalla.*


class Carta{
	var property position = game.at(1,1)
	const cards = [0,1,2,3,4,5,6,7,8,9]
}

class Suerte inherits Carta{
	method image() = "lucky" + cards.anyOne().toString() + ".png"
	
	method activar(){
		turno.playerOnTurn().cobrar(500)

		const luckyCardPopup = new Popup(img=self.image(),position=game.at(2,2))
		luckyCardPopup.addVisual()
		game.schedule(4000,{ luckyCardPopup.removeVisual() })
		
		game.sound("bonus.mp3").play()
		
		const suerteAnimation = new DineroModifier(img="mas500-")
		game.schedule(1000, {suerteAnimation.animation(4)})
	}
}

class Mufa inherits Suerte{
	override method image() = "mufa" + cards.anyOne().toString() + ".png"
	
	override method activar(){
		turno.playerOnTurn().pagar(500)
		
		const mufaCardPopup = new Popup(img=self.image(),position=game.at(2,2))
		mufaCardPopup.addVisual()
		game.schedule(4000,{ mufaCardPopup.removeVisual() })
		
		game.sound("mufa.mp3").play()
		
		const mufaAnimation = new DineroModifier(img="menos500-")
		game.schedule(1000, {mufaAnimation.animation(4)})
	}
}