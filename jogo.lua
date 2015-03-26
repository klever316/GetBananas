-- Requisita o storyboard e cria uma nova cena
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- Adiciona música em loop
bgSound = audio.loadStream( "jogo.mp3" )

mySong = audio.play( bgSound, { channel = 1, loops = -1 } )

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
left.x = 160
left.y = 265

local right = display.newImage( "images/right_button.png" )
right.x = 270
right.y = 265

local score = 0

local scoreNumber = display.newText(score, 400, 264, nil, 22)
scoreNumber.xScale = 1.2
scoreNumber.yScale = 1.2

local scoreText = display.newText("score:", 320, 265, nil, 22)
scoreText.xScale = 1.2

-- Cria uma função para gerar varios objetos
local function spawnBananas_g()
    local banana_g = display.newImage( "images/banana_g.png" )
    banana_g.x = math.random( 500 )
    physics.addBody( banana_g, { density = 2.0, friction = 0.5, bounce = 0.1} )

    local function banana_gRemove()
    display.remove( banana_g )
    banana_g=nil
    end
-- Função para colisão
    local function onLocalCollision( self, event )
       if ( event.phase == "began" ) then
          timer.performWithDelay(100, banana_gRemove)  
       end
       if event.other == monkey then
            
            local function updateScore()
            score = score + 1 
            scoreNumber.text = score
            end

            timer.performWithDelay( 1, updateScore ) 

            coinSound = audio.loadStream( "coin.mp3" )

            mySong = audio.play( coinSound, { channel = 2, loops = 0 } )

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

    local function banana_bRemove()
    display.remove( banana_b )
    banana_b=nil
    end
-- Função para colisão
    local function onLocalCollision( self, event )
       if ( event.phase == "began" ) then
          timer.performWithDelay(100, banana_bRemove)  
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
