WINDOW_HEIGHT=780 
WINDOW_WIDTH=1200

Class = require 'class'
require 'States/BaseState'
require 'StateMachine' 
require 'States/Main_Menu'
require 'States/Playstate'
require 'States/Credits'
require 'Player'
require 'Enemies'
require 'js'
push = require "push"

request_object="apo"
come_boys="aabbccddww"
function love.load() 
  
   
    love.graphics.setFont(love.graphics.newFont(30))
    --file=love.filesystem.newFile("__temp0")
    wf=require 'libraries/windfield/windfield' 
    sti = require 'libraries/Simple-Tiled-Implementation/sti' 
    anim8 =require 'libraries/anim8/anim8' 

    sprites={} 
    sprites.enemySheet =love.graphics.newImage('Images/bhopla2.png')


    img1=love.graphics.newImage('Images/moon.png')
    img3=love.graphics.newImage('Images/BHOOT.png')

    local enemygrid =anim8.newGrid(30,30,sprites.enemySheet:getWidth(),sprites.enemySheet:getHeight())

    world = wf.newWorld(0,300,false)  
    world:setQueryDebugDrawing(true) 
    world:addCollisionClass('Player') 
    world:addCollisionClass('Platform')
    world:addCollisionClass('Boundary')
    world:addCollisionClass('Danger')
    world:addCollisionClass('Flag')

    animations={} 
    animations.enemy=anim8.newAnimation(enemygrid('1-1',1),0.03)

    --push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT,1200,780,{
    --    vsync = true,
    --    fullscreen = false,
    --    resizable = true,
    --    pixelperfect=false, highdpi = true ,stretched = true
    --})
    gStateMachine=StateMachine
    { ['main_menu']= function() return Main_Menu() end,
      ['play']= function() return Playstate() end,
      ['credit']= function() return Credits() end 
    } 
    --sound=love.audio.newSource('Audio/Industrial Music Box - Kevin MacLeod.mp3',"stream")
    --sound:setLooping(true)
    --sound:play()
   -- sound:setVolume(0.1)
    keyboard_check={}
    gStateMachine:change('main_menu')

end 

function love.keypressed(key)
    keyboard_check[key]=true
  
end 
function Keyboard_was_Pressed(key)
    if keyboard_check[key] then
      return true
    else
      return false
    end
  end

function love.resize(w,h)
    --push:resize(w,h)
end 

function love.update(dt)
  if(JS.retrieveData(dt)) then
    --return
  end

  --file:open('r')
  --data=file:read()
  --request_object=data
  --file:close()

    if Keyboard_was_Pressed('t') then 
      JS.newRequest(JS.stringFunc(
        [[
            return "hello";
        ]]
    ))
    
     
    end 

    
    gStateMachine:update(dt)
    keyboard_check={}
end 

function love.mousepressed()
  
    --file:open('r')
  --data=file:read()
  --request_object=data
  --file:close()

  
  
  
end 

function love.draw()
    --push:start()  
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(img1,0,0,0,1,1.2)
  
    love.graphics.setColor(1,1,1,1)
   -- world:draw()
    gStateMachine:render()
   -- push:finish()
end 

