local storyboard = require("storyboard")
local scene = storyboard.newScene()

function scene:createScene(event)
local group = self.view

bgSound = audio.loadStream( "tutorial.mp3" )

toqueSound = audio.loadSound( "click.mp3" )

local bg = display.newImage('images/tutorial.png')
bg.x = 0
bg.y = display.contentHeight/13
group:insert(bg)

bg.alpha = -1;
transition.to(bg, {alpha = 1, time=2000})

back = display.newImage('images/menu.png', 80, 260)
group:insert(back)

back.alpha = -1;
transition.to(back, {alpha = 1, time=2000})

end

scene:addEventListener( "createScene", scene )

function stop()
     
     audio.stop( bgSound )
     audio.play( toqueSound )
	 display.remove(bg)
	 display.remove(back)
	 storyboard.gotoScene("menu", {effect = "slideLeft"})

end

function scene:enterScene( event )
	
	mySong = audio.play( bgSound, { channel = 1, loops = -1 } )

	back:addEventListener("tap",stop)
    
    storyboard.removeScene("jogo")
	storyboard.removeScene("go_tela")
	storyboard.removeScene("historia")
	storyboard.removeScene("menu")


end

scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )

	back:removeEventListener("tap",stop)
    audio.stop( 1 )

end

scene:addEventListener( "exitScene", scene )

return scene



