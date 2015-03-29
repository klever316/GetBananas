-- Requisita o storyboard e cria uma nova cena
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- Adiciona músicas
bgSound = audio.loadStream( "jogo.mp3" )

coinSound = audio.loadStream( "coin.mp3" )

gameoverSong = audio.loadStream( "game over.mp3" )

mainSong = audio.play( bgSound, { channel = 1, loops = -1 } )

--Adiciona física e gravidade
local physics = require("physics")
physics.start()
physics.setGravity( 0, 3 )
--physics.setDrawMode( "hybrid" )

-- Cria a função criar paredes, regula a velocidade e uma variavel para atribuir os movimentos 
function main( )
    createWalls()
end

motionx = 0; 
speed = 6;

--Cria física ajustada ao personagem via physics editor
local physicsData = (require "monkey_physics").physicsData(1.0)

-- Adiciona background, esquerda, direita, chão, macaco com física e chama física editada no physics editor
local background = display.newImage( "images/bg_jogo.png" )
background.y = display.contentHeight/13

local floor = display.newImage( "images/floor.png" )
floor.y = 258
physics.addBody( floor, "static", { friction=0.5, bounce=0 } )

local monkey = display.newImage( "images/monkey.png" )
monkey.y = 185
physics.addBody( monkey, "static", { radius = 0, friction= 0.5, bounce= 0 }, physicsData:get("monkey") )

local left = display.newImage( "images/left_button.png" )
left.x = 190
left.y = 265

local right = display.newImage( "images/right_button.png" )
right.x = 240
right.y = 265

--Adiciona score texto e número
local score = 0

local scoreNumber = display.newText(score, 400, 264, nil, 22)
scoreNumber:setTextColor( 0, 0, 1 )
scoreNumber.xScale = 1.2
scoreNumber.yScale = 1.2

local scoreText = display.newText("score:", 320, 265, nil, 22)
scoreText:setTextColor( 0, 0, 1 )
scoreText.xScale = 1.2

-- Cria uma função para gerar varios objetos
local function spawnBananas_g()
    local banana_g = display.newImage( "images/banana_g.png" )
    banana_g.x = math.random( 500 )
    physics.addBody( banana_g, { density = 2.0, friction = 0.5, bounce = 0.1} )
    
--Função para remover objeto quando colidir
    local function banana_gRemove()
    display.remove( banana_g )
    banana_g=nil
    end
-- Função para colisão e remoção do objeto 
    local function onLocalCollision( self, event )
       if ( event.phase == "began" ) then
          timer.performWithDelay(1, banana_gRemove)  
       end
--Se colidir com o objeto incrementa score 
       if event.other == monkey then
            
            local score = display.newText('+1', event.other.x, event.other.y, 'Courier New Bold', 14)
            score:setTextColor( 0, 0, 1 )
            transition.to(score, {time = 500, xScale = 1.5, yScale = 1.5, y = score.y - 20, onComplete = function() display.remove(score) score = nil end })

            scoreNumber.text = tostring(tonumber(scoreNumber.text) + 1)

            scoreSong = audio.play( coinSound, { channel = 2, loops = 0 } )

        end
    end

    banana_g.collision = onLocalCollision
    banana_g:addEventListener( "collision", banana_g )
end    
timer.performWithDelay( 800, spawnBananas_g, 0 )

-- Segunda função para criar objetos
local function spawnBananas_b()
    local banana_b = display.newImage( "images/banana_b.png" )
    banana_b.x = math.random( 1200 )
    physics.addBody( banana_b, { density = 2.0, friction = 0.5, bounce = 0.1} )
   
--Função para remover objeto quando colidir    
    local function banana_bRemove()
    display.remove( banana_b )
    banana_b=nil
    end
-- Função para colisão e remoção do objeto
    local function onLocalCollision( self, event )
       if ( event.phase == "began" ) then
          timer.performWithDelay(1, banana_bRemove)  
       end
--Se colidir com o objeto aciona game over
       if event.other == monkey then

         left:removeEventListener( 'touch', movemonkey )
         right:removeEventListener( 'touch', movemonkey )
         Runtime:removeEventListener( 'enterFrame', movemonkey )
         physics.pause( )
         audio.stop( 1 )
         local gameover = display.newText( "GAME OVER", 120, 130, native.systemFontBold, 40)
         gameover:setTextColor( 0, 0, 0 )
         gameoverSound = audio.play( gameoverSong, { channel = 1, loops = 0 } )

       end
    end
    banana_b.collision = onLocalCollision
    banana_b:addEventListener( "collision", banana_b )
end    
timer.performWithDelay( 300, spawnBananas_b, 0 )

-- Função para criar paredes
function createWalls( )
    
     local wallThickenss = 10

     --left wall
     local wall = display.newRect( -15, 160, wallThickenss, display.contentHeight )
     physics.addBody( wall, "static", { friction = 0, bounce = 1 } )

     --right wall 
     wall = display.newRect( display.contentWidth+1 + wallThickenss, 160, wallThickenss, display.contentHeight ) 
     physics.addBody( wall, "static", { friction = 0, bounce = 1 } )

end

main()  

-- Adiciona movimento do personagem de parada e de ir para a direita e esqueda
local function stop (event)
    if event.phase =="ended" then
        motionx = 0;
    end     
end
Runtime:addEventListener("touch", stop )

local function movemonkey (event)
    monkey.x = monkey.x + motionx;
end
Runtime:addEventListener("enterFrame", movemonkey)
 
function left:touch()
    motionx = -speed;
end
left:addEventListener("touch",left)

function right:touch()
    motionx = speed;
end
right:addEventListener("touch",right)

return scene
