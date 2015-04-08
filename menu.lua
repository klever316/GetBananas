-- Adiciona música em loop
bgSound = audio.loadStream( "menu.mp3" )

mySong = audio.play( bgSound, { channel = 1, loops = -1 } )

-- Requisita o storyboard, inclui o arquivo play as telas do jogo e insere um botão para redirecionar para a tela do jogo
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local playbutton

-- Cria o background da tela, botão e os insere dentro do objeto group
function scene:createScene( event )
        local group = self.view
        
        local background = display.newImage( "images/bg.png" )
        background.y = display.contentHeight/13
		group:insert(background)
	
        playbutton= display.newImage( "images/play.png" )
        playbutton.x = display.contentWidth/3 - 90
        playbutton.y = display.contentHeight/2 
		group:insert(playbutton)
end

-- Adicionar as funções de iniciar,entrada e saída das cenas
function startGame()
	 storyboard.gotoScene("jogo")
end

function scene:enterScene( event )
	playbutton:addEventListener("tap",startGame)
end

function scene:exitScene( event )
	playbutton:removeEventListener("tap",startGame)
	audio.stop( )
end

-- Recebe os metodos criados
scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

return scene

