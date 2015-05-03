--------------------------------------------MENU DO JOGO E SUAS CONFIGURAÇÕES--------------------------------------------

-- Requisita o storyboard e adiciona a variável playbutton que irá redirecionar para a tela do jogo 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local playbutton
local tutorialbutton
local historiabutton
local creditosbutton

-- Carrega o arquivo de aúdio da tela do menu
bgSound = audio.loadStream( "menu.mp3" )

_W = display.contentWidth 
_H = display.contentHeight

-- Função cretescene do storyboard onde serão inseridos elementos que iram aparecer na tela de menu
function scene:createScene( event )
        local group = self.view
        
        local background = display.newImage( "images/bg.png" )
        background.y = display.contentHeight/13
        background.alpha = -1;
        transition.to(background, {alpha = 1, time=1000})
		group:insert(background)

		local logo = display.newImage( "images/menu_logo.png" )
        logo.x = -5
        logo.y = 30
        
        group:insert( logo )

        local vine = display.newImage( "images/mvine.png" )
        vine.x = -150
        vine.y = 20
        group:insert( vine )

        local function move_vine( vine )
	    vine.x = -300
	    transition.to( vine, {x=0+_W+100, time=8000} )
	    logo.alpha = -1;
        transition.to(logo, {alpha = 1, time=10000})
        end
        move_vine( vine )
	
        playbutton= display.newImage( "images/play.png" )
        playbutton.x = display.contentWidth/3 + 12
        playbutton.y = display.contentHeight/2 - 30 
        playbutton.alpha = -1;
        transition.to(playbutton, {alpha = 1, time=5000})
		group:insert(playbutton)

        tutorialbutton= display.newImage( "images/comojogar.png" )
        tutorialbutton.x = display.contentWidth/3 - 5
        tutorialbutton.y = display.contentHeight/2 + 10 
        tutorialbutton.alpha = -1;
        transition.to(tutorialbutton, {alpha = 1, time=5000})
        group:insert(tutorialbutton)

        historiabutton= display.newImage( "images/historialogo.png" )
        historiabutton.x = display.contentWidth/3 - 5
        historiabutton.y = display.contentHeight/2 + 50 
        historiabutton.alpha = -1;
        transition.to(historiabutton, {alpha = 1, time=5000})
        group:insert(historiabutton)

        creditosbutton= display.newImage( "images/creditoslogo.png" )
        creditosbutton.x = display.contentWidth/3 - 10
        creditosbutton.y = display.contentHeight/2 + 90 
        creditosbutton.alpha = -1;
        transition.to(creditosbutton, {alpha = 1, time=5000})
        group:insert(creditosbutton)
end
-- Comando responsável por ativar a função createscene
scene:addEventListener( "createScene", scene )

-- Função que redirecionará para a tela do jogo 
function startGame()
	 audio.stop( )
	 display.remove(background)
	 display.remove(playbutton)
     display.remove(tutorialbutton)
     display.remove(historiabutton)
     display.remove(creditosbutton)
	 display.remove(vine)
	 display.remove(logo)
	 transition.cancel( background )
	 transition.cancel( logo )
	 transition.cancel( playbutton )
	 storyboard.gotoScene("jogo")
end

function tutorial()
     audio.stop( )
     display.remove(background)
     display.remove(playbutton)
     display.remove(tutorialbutton)
     display.remove(historiabutton)
     display.remove(creditosbutton)
     display.remove(vine)
     display.remove(logo)
     transition.cancel( background )
     transition.cancel( logo )
     transition.cancel( playbutton )
     storyboard.gotoScene("tutorial")
end

function historia()
     audio.stop( )
     display.remove(background)
     display.remove(playbutton)
     display.remove(tutorialbutton)
     display.remove(historiabutton)
     display.remove(creditosbutton)
     display.remove(vine)
     display.remove(logo)
     transition.cancel( background )
     transition.cancel( logo )
     transition.cancel( playbutton )
     storyboard.gotoScene("historia")
end

function creditos()
     audio.stop( )
     display.remove(background)
     display.remove(playbutton)
     display.remove(tutorialbutton)
     display.remove(historiabutton)
     display.remove(creditosbutton)
     display.remove(vine)
     display.remove(logo)
     transition.cancel( background )
     transition.cancel( logo )
     transition.cancel( playbutton )
     storyboard.gotoScene("creditos")
end

-- Função enterScene do storyboard que irá executar o som de fundo do jogo e ativará o objeto playbutton
function scene:enterScene( event )
	mySong = audio.play( bgSound, { channel = 1, loops = -1 } )
    
    storyboard.removeScene("go_tela")
    storyboard.removeScene("tutorial")
    storyboard.removeScene("historia")
    storyboard.removeScene("creditos")

	playbutton:addEventListener("tap",startGame)
    tutorialbutton:addEventListener("tap",tutorial)
    historiabutton:addEventListener("tap",historia)
    creditosbutton:addEventListener("tap",creditos)
end

-- Comando responsável por ativar a função enterscene
scene:addEventListener( "enterScene", scene )

-- Função exitscene do storyboard onde removerá o objeto playbutton e parar o audio
function scene:exitScene( event )
	playbutton:removeEventListener("tap",startGame)
    tutorialbutton:removeEventListener("tap",tutorial)
    historiabutton:removeEventListener("tap",historia)
    creditosbutton:removeEventListener("tap",creditos)
	audio.stop( )
end

-- Comando responsável por ativar a função exitscene
scene:addEventListener( "exitScene", scene )

return scene

