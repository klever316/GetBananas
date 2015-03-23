-- Esconde a barra de status, define os pontos de âncoragem e cria aleatorias posições para os objetos
display.setStatusBar(display.HiddenStatusBar)
display.setDefault( "anchorX", 0)
display.setDefault( "anchorY", 0)
math.randomseed( os.time() )

-- Requisita o storyboard e vai para a tela do jogo
local storyboard = require "storyboard"
storyboard.gotoScene( "menu" )