player={}
player.width=32
player.height=74
player.x=game_width/2-player.width/2
player.y=game_height-150-75
player.speed=500
--------------------------------------------------------------------------------Heads Up Display variables
player.health=10
player.maxhealth=10
Many_bullets = {}

function player_update(dt)
    ---Movement---
    if love.keyboard.isDown('a') then
        player.x=math.max(0,player.x-player.speed*dt)
    end
    if love.keyboard.isDown('d') then
        player.x=math.min(game_width-player.width,player.x+player.speed*dt)
    end

     ---bullets upward movement
     for keys,values in pairs(Many_bullets) do
        values.y=values.y-values.speed*dt
        --- deletion as they cross screen
        if values.y < -values.height then
            table.remove(Many_bullets,keys)
        end
    end
end

function CreateBullets()
    Bullet = {}
    Bullet.width = 10
    Bullet.height = 10
    Bullet.y = player.y
    Bullet.x = player.x + (player.width/2) - (Bullet.width/2)
    Bullet.speed = 800
    return Bullet
  end


function player_render()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(player_image,player.x,player.y)
    love.graphics.setColor(1,1,1)
     -- Bullets render
     for keys,values in pairs(Many_bullets) do
        love.graphics.rectangle("fill",values.x,values.y,values.width,values.height,50)
    end
    ----------------------------------------------------------------------------G U I
    
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("fill",1001,101+136,20*player.health,20)
    love.graphics.setFont(love.graphics.newFont("Extra/font.ttf",15))
    love.graphics.print(score,1001+85,101+136+275)
    love.graphics.setFont(love.graphics.newFont(1))
    love.graphics.setColor(1,1,1)
end
