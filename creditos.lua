local storyboard = require("storyboard")
local scene = storyboard.newScene()

function scene:createScene(event)
local group = self.view

bgSound = audio.loadStream( "creditos.mp3" )

local bg = display.newImage('images/creditos.png')
bg.x = 0
bg.y = display.contentHeight/13
group:insert(bg)

bg.alpha = -1;
transition.to(bg, {alpha = 1, time=2000})

back = display.newImage('images/menu.png', 80, 265)
group:insert(back)

back.alpha = -1;
transition.to(back, {alpha = 1, time=2000})

logo = display.newImage( "images/developed.png" )
logo.x = 260
logo.y = 270
logo.alpha = -1
group:insert(logo)

transition.to(logo, {alpha = 1, time=5000, onComplete=logo1})

end

scene:addEventListener( "createScene", scene )

function stop()
     
     audio.stop( )
	 display.remove(bg)
	 display.remove(back)
	 display.remove(logo)
	 storyboard.gotoScene("menu")

end

function scene:enterScene( event )
	
	mySong = audio.play( bgSound, { channel = 1, loops = -1 } )

	back:addEventListener("tap",stop)
    
    storyboard.removeScene("jogo")
    storyboard.removeScene("tutorial")
    storyboard.removeScene("historia")
	storyboard.removeScene("go_tela")
	storyboard.removeScene("menu")


end

scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )

	back:removeEventListener("tap",stop)
    audio.stop( )

end

scene:addEventListener( "exitScene", scene )

return scene



