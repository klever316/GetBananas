--------------------------------------------MAIN QUE IRÁ REDIRECIONAR PARA O STORYBOARD MENU--------------------------------------------

-- Esconde a barra de status e define as posições X e Y das telas do jogo
display.setStatusBar(display.HiddenStatusBar)
display.setDefault( "anchorX", 0)
display.setDefault( "anchorY", 0)

-- Requisita o storyboard e vai para a tela do menu
local storyboard = require "storyboard"
storyboard.gotoScene( "menu", "crossFade", 1000 )