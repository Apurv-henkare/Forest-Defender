---- Resolutions ---
window_width=1300
window_height=750
game_width=900
game_height=750
---------------------

-- Global variables --
Timer=0
state="menu"
score=0
------------------


require 'Player'
require 'Enemies'
push=require 'push'
math.randomseed(os.time())


function love.load()
   ----load game screen ---
 
   push:setupScreen(window_width,window_height,window_width,window_height,{
    vsync = true,
    fullscreen = true,
    resizable = true,
    pixelperfect=false, highdpi = true ,stretched = true
})
   ---load images--
   background=love.graphics.newImage('Images/bg final.jpg')
   enemy_image=love.graphics.newImage('Images/Zombie final.png')
   player_image=love.graphics.newImage('Images/canon final.png')
   right_menu=love.graphics.newImage('Images/menu.jpg')
   main_menu=love.graphics.newImage('Images/main menu.jpg')
   exit_image=love.graphics.newImage('Images/end.jpg')

   sound=love.audio.newSource('Extra/background_sound.mp3','stream')
   sound:setLooping(true)
   sound:setVolume(0.5)
   sound:play()
end

function love.resize(w,h)
  push:resize(w,h)
end 

function love.update(dt)
  if(state=="play")then
      Timer=Timer+dt
      if Timer >0.1 then
          table.insert(Many_bullets,CreateBullets())
          Timer=0
      end

      if math.random() <0.03 then
          table.insert(Many_enemies,CreateEnemies())
      end

      player_update(dt)
      enemies_update(dt)

      for i,v in pairs(Many_bullets) do
          for j,k in pairs(Many_enemies) do
              if Collision(v,k) then
                table.remove(Many_bullets,i)
                table.remove(Many_enemies,j)
                score=score+1
              end
        end
      end
      if(player.health <= 0)then
        state="end"
      end 
  elseif(state == "end") then 
    Many_bullets={}
    Many_enemies={}
    player.health=player.maxhealth
  elseif(state == "menu")then
      player.health=player.maxhealth
      score=0
  end
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end
    if state=="menu" and key=="return" then
      state="play"
    end

    if state == "end" and key == "return" then
      state="menu"
    end 

end

function Collision(v,k)
    return v.x<k.x+k.width and
           v.x+v.width>k.x and
           v.y<k.y+k.height and
           v.y+v.height>k.y
end

function love.draw()
    -- Line separation ---
    push:start()

    if state == "menu" then 
      love.graphics.draw(main_menu,0,0)
    elseif state == "end" then 
      love.graphics.draw(exit_image,0,0)
      love.graphics.setColor(0,0,0)
      love.graphics.setFont(love.graphics.newFont("Extra/font.ttf",30))
      love.graphics.print("Score :"..tostring(score),window_width/2-150,window_height/2-150)
      love.graphics.print("Press ESC to QUIT",window_width/2-250,window_height/2-50)
      love.graphics.print("Press Enter to Play",window_width/2-250,window_height/2+50)
    else 
      love.graphics.setLineWidth(5)
      love.graphics.line(game_width,0,game_width,game_height)
      love.graphics.setLineWidth(1)
      love.graphics.draw(background,0,0)
      love.graphics.setColor(122/255,104/255,39/255)
      love.graphics.setLineWidth(20)
      love.graphics.line(game_width,0,game_width,game_height)
      love.graphics.setLineWidth(1)
      love.graphics.setColor(1,1,1)
      love.graphics.draw(right_menu,900,0)
      player_render()
      enemies_render()
    end 

    love.graphics.setColor(1,1,1)
  
    push:finish()
end
