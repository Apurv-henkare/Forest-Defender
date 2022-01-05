Many_enemies ={}

function CreateEnemies()
    Enemy = {}
    Enemy.width = 50
    Enemy.height = 50
    Enemy.x = math.random(0,game_width-Enemy.width)
    Enemy.y = math.random(-70,-50)
    Enemy.speed = math.random(80,350)
    Enemy.col=false
    return Enemy
end

function enemies_update(dt)

    for keys,values in pairs(Many_enemies) do
        values.y = values.y + values.speed*dt

        if values.y>game_height-75-50 then
            table.remove(Many_enemies,keys)
            player.health=player.health-1
        end
    end
end

function enemies_render()
    for keys,values in pairs(Many_enemies) do
        --love.graphics.rectangle("fill",values.x,values.y,values.width,values.height)
        love.graphics.draw(enemy_image,values.x,values.y)
    end
end
