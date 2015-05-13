-- Requisita o storyboard e cria uma nova cena
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local w = display.contentWidth 
local h = display.contentHeight 

local playerIsInvincible = false

local numberOfLives = 3

local countVidas = 3

local int controlePonto = 0

local yAxis = 0

local xAxis = 0

local score = 0

scoreFinal = 0

-- Adiciona músicas
bgSound = audio.loadStream( "jogo.mp3" )

coinSound = audio.loadStream( "coin.mp3" )

wrongSong = audio.loadStream( "wrong.mp3" )

wizardSong = audio.loadStream( "wizardsound.mp3" )

function scene:createScene(event)
local group = self.view

--Adiciona física e gravidade
local physics = require("physics")
physics.start()
physics.setGravity( 0, 1 )
--physics.setDrawMode( "hybrid" )

-- Cria a função criar paredes, regula a velocidade e uma variavel para atribuir os movimentos 
function main( )
    createWalls()
end

--Cria física ajustada ao personagem via physics editor

local physicsData = (require "mkp").physicsData(1.0)

local sheetData =  { width=56, height=48, numFrames=30 }

local sheet = graphics.newImageSheet("images/sprites.png", sheetData)

local sequenceData = 
{   
    { name = "idleLeft", start = 16, count = 1, time = 0, loopCount = 1 }, 
    { name = "idleRight", start = 1, count = 1, time = 0, loopCount = 1 }, 

    { name = "moveLeft", start = 16, count = 16, time = 300, loopCount = 0 },
    { name = "moveRight", start = 1, count = 15, time = 300, loopCount = 0 },
}

local lifeOptions = require ( "spriteVidas" )
local folhaVidas = graphics.newImageSheet("images/spriteVidas.png", lifeOptions.sheetData)
local sequenceVidas = {
    { name = "vidas3", start = 3, count = 1, time = 0, loopCount = 1 },
    { name = "vidas2", start = 2, count = 1, time = 0, loopCount = 1 },
    { name = "vidas1", start = 1, count = 1, time = 0, loopCount = 1 }
}

-- Adiciona background, esquerda, direita, chão, macaco com física e chama física editada no physics editor
local background = display.newImage( "images/bg_jogo.png" )
background.y = display.contentHeight/13
background.alpha = -1
transition.to(background, {alpha = 1, time=1000})
group:insert(background)

button_left = display.newImage( "images/displayleft.png" )
button_left.x = 5
button_left.y = 110
button_left.alpha = -1
button_left.xScale = 0.3
button_left.yScale = 0.3
transition.to(button_left, {alpha = 0.8, time=1000})
group:insert(button_left)

button_right = display.newImage( "images/displayright.png" )
button_right.x = 430
button_right.y = 110
button_right.alpha = -1
button_right.xScale = 0.3
button_right.yScale = 0.3
transition.to(button_right, {alpha = 0.8, time=1000})
group:insert(button_right)

wizard = display.newImage( "images/wizard.png" )
wizard.x = 180
wizard.y = 55
wizard.alpha = -1
group:insert(wizard)

wizard1 = display.newImage( "images/wizard.png" )
wizard1.x = 180
wizard1.y = 55
wizard1.alpha = -1
group:insert(wizard1)

wizard2 = display.newImage( "images/wizard.png" )
wizard2.x = 180
wizard2.y = 55
wizard2.alpha = -1
group:insert(wizard2)

wizard3 = display.newImage( "images/wizard.png" )
wizard3.x = 180
wizard3.y = 55
wizard3.alpha = -1
group:insert(wizard3)

wizard4 = display.newImage( "images/wizard.png" )
wizard4.x = 180
wizard4.y = 55
wizard4.alpha = -1
group:insert(wizard4)

wizard5 = display.newImage( "images/wizard.png" )
wizard5.x = 180
wizard5.y = 55
wizard5.alpha = -1
group:insert(wizard5)

wizard6 = display.newImage( "images/wizard.png" )
wizard6.x = 180
wizard6.y = 55
wizard6.alpha = -1
group:insert(wizard6)

wizard7 = display.newImage( "images/wizard.png" )
wizard7.x = 180
wizard7.y = 55
wizard7.alpha = -1
group:insert(wizard7)

wizard8 = display.newImage( "images/wizard.png" )
wizard8.x = 180
wizard8.y = 55
wizard8.alpha = -1
group:insert(wizard8)

wizard9 = display.newImage( "images/wizard.png" )
wizard9.x = 180
wizard9.y = 55
wizard9.alpha = -1
group:insert(wizard9)

local floor = display.newImage( "images/floor.png" )
floor.y = 258
floor.alpha = -1;
transition.to(floor, {alpha = 1, time=15000})
physics.addBody( floor, "static", { friction=0.5, bounce=0 } )
group:insert(floor)

local monkey = display.newSprite(sheet, sequenceData )
monkey.y = 210
physics.addBody( monkey, "static", { radius = 0, friction= 0.5, bounce= 0 }, physicsData:get("sprites") )
monkey.name = "macaco"
monkey.alpha = -1;
transition.to(monkey, {alpha = 1, time=1000})
group:insert(monkey);

monkey:setSequence("idleRight")

local Vidas = display.newSprite( folhaVidas, sequenceVidas )

Vidas.x = 30
Vidas.y = 266
Vidas.alpha = -1;
transition.to(Vidas, {alpha = 1, time=1000})
Vidas:setSequence ( " vidas3 ")
Vidas:play( )
group:insert(Vidas);

local buttons = {}

buttons[1] = display.newImageRect("images/left_button.png",250,295)
buttons[1].x = -30
--buttons[1].y = 265
buttons[1].alpha = 0.01;
--transition.to(buttons[1], {alpha = 1, time=1000})
buttons[1].myName = "left"

group:insert(buttons[1])

buttons[2] = display.newImageRect("images/right_button.png",250,295)
buttons[2].x = 250
--buttons[2].y = 265
buttons[2].alpha = 0.01;
--transition.to(buttons[2], {alpha = 1, time=1000})
buttons[2].myName = "right"

group:insert(buttons[2])

--Adiciona score texto e número
local scoreNumber = display.newText(score, 415, 261, 'MV Boli', 22)
scoreNumber: setTextColor( 240, 248, 0 )
scoreNumber.xScale = 1.2
scoreNumber.yScale = 1.2
scoreNumber.alpha = -1;
transition.to(scoreNumber, {alpha = 1, time=1000})
group:insert(scoreNumber);

local scoreText = display.newText("Pontos", 320, 264, 'MV Boli', 22)
scoreText: setTextColor( 240, 248, 0 )
scoreText.xScale = 1.2
scoreText.alpha = -1;
transition.to(scoreText, {alpha = 1, time=1000})
group:insert(scoreText);

-- Cria uma função para gerar varios objetos
 function spawnBananas_g()
    local banana_g = display.newImage( "images/banana_g.png" )
    banana_g.x = math.random( 500 )
    physics.addBody( banana_g, { density = 2.0, friction = 0.5, bounce = 0.1} )
    group:insert(banana_g);
    
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
            
            local score = display.newText('+1', event.other.x, event.other.y, --[['Courier New Bold']]'MV Boli', 14)
            score: setTextColor( 240, 248, 0 )
            transition.to(score, {time = 500, xScale = 1.5, yScale = 1.5, y = score.y - 20, onComplete = function() display.remove(score) score = nil end })
            
            controlePonto = tonumber(scoreNumber.text)

            scoreNumber.text = tostring(tonumber(scoreNumber.text) + 1)
            scoreFinal = tonumber(scoreNumber.text)

            if controlePonto == 9 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 19 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 29 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 39 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 49 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 59 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 69 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 79 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 89 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto == 99 then
                mageSong = audio.play( wizardSong, { channel = 4, loops = 0 } )
            end

            if controlePonto >8 and controlePonto <18 then
                transition.to(wizard, {alpha = 1, time=2500, onComplete = removewizard})
                physics.setGravity( 0, 2 )
            
            elseif controlePonto >18 and controlePonto <28 then
                transition.to(wizard1, {alpha = 1, time=2500, onComplete = removewizard1})
                physics.setGravity( 0, 3 )

            elseif controlePonto >28 and controlePonto <38 then
                transition.to(wizard2, {alpha = 1, time=2500, onComplete = removewizard2})
                physics.setGravity( 0, 4 )

            elseif controlePonto >38 and controlePonto <48 then
                transition.to(wizard3, {alpha = 1, time=2500, onComplete = removewizard3})
                physics.setGravity( 0, 5 )    

            elseif controlePonto >48 and controlePonto <58 then
                transition.to(wizard4, {alpha = 1, time=2500, onComplete = removewizard4})
                physics.setGravity( 0, 6 )

            elseif controlePonto >58 and controlePonto <68 then
                transition.to(wizard5, {alpha = 1, time=2500, onComplete = removewizard5})
                physics.setGravity( 0, 7 )

            elseif controlePonto >68 and controlePonto <78 then
                transition.to(wizard6, {alpha = 1, time=2500, onComplete = removewizard6})
                physics.setGravity( 0, 8 )

            elseif controlePonto >78 and controlePonto <88 then
                transition.to(wizard7, {alpha = 1, time=2500, onComplete = removewizard7})
                physics.setGravity( 0, 9 )

            elseif controlePonto >88 and controlePonto <98 then
                transition.to(wizard8, {alpha = 1, time=2500, onComplete = removewizard8})
                physics.setGravity( 0, 10 )

            elseif controlePonto >98 then
                transition.to(wizard9, {alpha = 1, time=2500, onComplete = removewizard9})
                physics.setGravity( 0, 11 )            
            end

            scoreSong = audio.play( coinSound, { channel = 2, loops = 0 } )
        end
    end

    banana_g.collision = onLocalCollision
    banana_g:addEventListener( "collision", banana_g ) 

end 
tm1 = timer.performWithDelay( 800, spawnBananas_g, 0 )

function removewizard( )
    display.remove( wizard )
end

function removewizard1( )
    display.remove( wizard1 )
end

function removewizard2( )
    display.remove( wizard2 )
end

function removewizard3( )
    display.remove( wizard3 )
end

function removewizard4( )
    display.remove( wizard4 )
end

function removewizard5( )
    display.remove( wizard5 )
end

function removewizard6( )
    display.remove( wizard6 )
end

function removewizard7( )
    display.remove( wizard7 )
end

function removewizard8( )
    display.remove( wizard8 )
end

function removewizard9( )
    display.remove( wizard9 )
end

-- Segunda função para criar objetos
 function spawnBananas_b()
    local banana_b = display.newImage( "images/banana_b.png" )
    banana_b.x = math.random( 1200 )
    physics.addBody( banana_b, { density = 2.0, friction = 0.5, bounce = 0.1} )
    group:insert(banana_b);
   
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

         countVidas = countVidas - 1
         Vidas:setSequence( "vidas"..countVidas )
         if(playerIsInvincible == false) then
                killPlayer()
         end

         badSong = audio.play( wrongSong, { channel = 3, loops = 0 } )

       end
    end
    banana_b.collision = onLocalCollision
    banana_b:addEventListener( "collision", banana_b )
end    
tm2 = timer.performWithDelay( 300, spawnBananas_b, 0 )

function killPlayer()
    numberOfLives = numberOfLives - 1;
     if(numberOfLives == 0) then
         physics.pause( )
         timer.cancel( tm1 )
         timer.cancel( tm2 )
         timer.cancel( teste )
         storyboard.gotoScene("go_tela");
      else
          spawnNewPlayer()
          playerIsInvincible = true

    end
end

function spawnNewPlayer()
    local numberOfTimesToFadePlayer = 3
    local numberOfTimesPlayerHasFaded = 0
    local  function fadePlayer()
        monkey.alpha = 0;
        transition.to( monkey, {time=400, alpha=1,  })
        numberOfTimesPlayerHasFaded = numberOfTimesPlayerHasFaded + 1

    if(numberOfTimesPlayerHasFaded == numberOfTimesToFadePlayer) then
        playerIsInvincible = false
    end
  end
     fadePlayer()
     timer.performWithDelay(200, fadePlayer,numberOfTimesToFadePlayer)
end

-- Função para criar paredes
function createWalls( )
    
     local wallThickenss = 10

     --left wall
     local wall = display.newRect( -15, 160, wallThickenss, display.contentHeight )
     physics.addBody( wall, "static", { friction = 0, bounce = 1 } )
     group:insert(wall);

     --right wall 
     wall = display.newRect( display.contentWidth+1 + wallThickenss, 160, wallThickenss, display.contentHeight ) 
     physics.addBody( wall, "static", { friction = 0, bounce = 1 } )
     group:insert(wall);

end

main()  

local touchFunction = function(e)
    local eventName = e.phase
    local direction = e.target.myName
    
    if eventName == "began" or eventName == "moved" then
        
        if direction == "right" then
            monkey:setSequence("moveRight")

            xAxis = 6
            yAxis = 0
        elseif direction == "left" then
            monkey:setSequence("moveLeft")

            xAxis = -6
            yAxis = 0
        end
        
        monkey:play() --executa a animação, é necessário usar essa função para ativar a animação
    else 
        
        if e.target.myName == "right" then
            monkey:setSequence("idleRight")
        elseif e.target.myName == "left" then
            monkey:setSequence("idleLeft")
        end
        
        yAxis = 0
        xAxis = 0
    end
end

local j=1

for j=1, #buttons do 
    buttons[j]:addEventListener("touch", touchFunction)
end

local update = function()
    monkey.x = monkey.x + xAxis
    monkey.y = monkey.y + yAxis

    if monkey.x <= monkey.width * .10 then 
        monkey.x = monkey.width * .10
    elseif monkey.x >= w - monkey.width * .9 then 
        monkey.x = w - monkey.width * .9
    end

    if monkey.y <= monkey.height * .5 then
        monkey.y = monkey.height * .5
    elseif monkey.y >= h - monkey.height * .5 then 
        monkey.y = h - monkey.height * .5
    end 
end

teste = timer.performWithDelay( 20, update, 0 )
end

scene:addEventListener("createScene", scene)

function scene:enterScene(event)
    local group = self.view;

    storyboard.removeScene("menu")
    storyboard.removeScene("tutorial")
    storyboard.removeScene("historia")
    storyboard.removeScene("go_tela")


    mainSong = audio.play( bgSound, { channel = 1, loops = -1 } )
end

scene:addEventListener("enterScene", scene)

function scene:exitScene(event)
    local group = self.view

    audio.stop(mainSong)
end

scene:addEventListener("exitScene", scene)

return scene
