-- Adiciona música em loop
bgSound = audio.loadStream( "game over.mp3" )

mySong = audio.play( bgSound, { channel = 1, loops = 0 } )

-- Requisita o storyboard, inclui o arquivo play as telas do jogo e insere um botão para redirecionar para a tela do jogo
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local retry
local menu

-- Cria o background da tela, botão e os insere dentro do objeto group
function scene:createScene( event )
        local group = self.view
        
        local background = display.newImage( "images/gameover.png" )
        background.y = display.contentHeight/13
        background.alpha = -1;
        transition.to(background, {alpha = 1, time=1000})
		group:insert(background)

        local logo = display.newImage( "images/go_logo.png" )
        logo.x = -10
        logo.y = 35
        group:insert( logo )

        local face = display.newImage( "images/sadmonkey.png" )
        face.x = 250
        face.y = 140
        face.xScale = 0.01
        face.yScale = 0.01
        group:insert(face)

        --transition.scaleTo( face, { xScale=0.1, yScale=0.1, time=1000} )
	
        retry= display.newImage( "images/retry.png" )
        retry.x = -100
        retry.y = 260
        retry.alpha = -1
        transition.to(retry, {alpha = 1, time=4000})
		group:insert(retry)

        menu= display.newImage( "images/menu.png" )
        menu.x = 280
        menu.y = 255
        menu.alpha = -1
        transition.to(menu, {alpha = 1, time=4000})
        group:insert(menu)

        yourscore= display.newImage( "images/yourscore.png" )
        yourscore.x = 250
        yourscore.y = 100
        group:insert(yourscore)

		scoreFinal = (scoreFinal)
		
		local pontuacaoFinal = display.newText(scoreFinal, 380, 134, native.systemFont, 20)
        pontuacaoFinal: setTextColor( 240, 248, 0 )
                    
        group:insert(pontuacaoFinal)
end

scene:addEventListener( "createScene", scene )

-- Adicionar as funções de iniciar,entrada e saída das cenas
function retryGame()
     scoreFinal = 0
     
     display.remove(background)
     transition.cancel( background )
     display.remove( logo )
     display.remove( retry )
     display.remove( face )
     display.remove( menu )
     display.remove( yourscore )
     display.remove(pontuacaoFinal);

	 storyboard.gotoScene("jogo")
end

function backMenu()
     scoreFinal = 0
     
     display.remove(background)
     transition.cancel( background )
     display.remove( logo )
     display.remove( retry )
     display.remove( face )
     display.remove( menu )
     display.remove( yourscore )
     display.remove(pontuacaoFinal);

     storyboard.gotoScene("menu")
end

function scene:enterScene( event )
    local group = self.view;

    storyboard.removeScene("jogo");

	retry:addEventListener("tap",retryGame)
    menu:addEventListener("tap",backMenu)
end

scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
	retry:removeEventListener("tap",retryGame)
    menu:removeEventListener("tap",backMenu)
	audio.stop( 1 )
end

scene:addEventListener( "exitScene", scene )

return scene

