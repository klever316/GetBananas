LINHA 1 Menu
--------------------------------------------MENU DO JOGO E SUAS CONFIGURAÇÕES--------------------------------------------

-- Requisita o storyboard e adiciona a variável playbutton que irá redirecionar para a tela do jogo 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local playbutton

-- Carrega o arquivo de aúdio da tela do menu
bgSound = audio.loadStream( "menu.mp3" )

-- Função cretescene do storyboard onde serão inseridos elementos que iram aparecer na tela de menu
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
-- Comando responsável por ativar a função createscene
scene:addEventListener( "createScene", scene )

-- Função que redirecionará para a tela do jogo 
function startGame()
	 audio.stop( )
	 display.remove(background)
	 display.remove(playbutton)
	 storyboard.gotoScene("jogo")
end

-- Função enterScene do storyboard que irá executar o som de fundo do jogo e ativará o objeto playbutton
function scene:enterScene( event )
	mySong = audio.play( bgSound, { channel = 1, loops = -1 } )
    
    storyboard.removeScene("go_tela")

	playbutton:addEventListener("tap",startGame)
end

-- Comando responsável por ativar a função enterscene
scene:addEventListener( "enterScene", scene )

-- Função exitscene do storyboard onde removerá o objeto playbutton e parar o audio
function scene:exitScene( event )
	playbutton:removeEventListener("tap",startGame)
	audio.stop( )
end

-- Comando responsável por ativar a função exitscene
scene:addEventListener( "exitScene", scene )

return scene

