win = 0
function love.load()
love.window.setTitle("Pinball")
w,h = love.graphics.getDimensions()
world = love.physics.newWorld(0,0, true)
pointP,pointC = 0,0
c = {}
rp,ri = {},{}
fu,fd = {},{}
c.b = love.physics.newBody(world,w/2,h/2,"dynamic")
c.s = love.physics.newCircleShape(10)
c.f = love.physics.newFixture(c.b, c.s, 20)
c.f:setRestitution(0)
c.b:isBullet()
rp.b = love.physics.newBody(world,w/6, h/2,"static")
rp.s = love.physics.newRectangleShape(15,100)
rp.f = love.physics.newFixture(rp.b, rp.s, 1000)
rp.f:setRestitution(1)
ri.b = love.physics.newBody(world,5*(w/6), h/2,"static")
ri.s = love.physics.newRectangleShape(15,100)
ri.f = love.physics.newFixture(ri.b, ri.s, 1000)
ri.f:setRestitution(1)
fu.b = love.physics.newBody(world,(w/2), 1,"static")
fu.s = love.physics.newRectangleShape(w,1)
fu.f = love.physics.newFixture(fu.b, fu.s, 1000)
fu.f:setRestitution(1)
fd.b = love.physics.newBody(world,(w/2), h-1,"static")
fd.s = love.physics.newRectangleShape(w,1)
fd.f = love.physics.newFixture(fd.b, fd.s, 1000)
fd.f:setRestitution(1)
c.b:setLinearVelocity(300, 50)
end

function love.update(dt)
dt = 1/40
world:update(dt)

hold()
whoPoint()
if love.keyboard.isDown("i") then
 love.load()
end

if love.keyboard.isDown("r") then
 restart()
end

if love.keyboard.isDown("up") then
 rp.b:setY(rp.b:getY() - 5)
end
if love.keyboard.isDown("down") then
 rp.b:setY(rp.b:getY() + 5)
end
move()
end

function love.draw()
love.graphics.polygon("fill",rp.b:getWorldPoints(rp.s:getPoints()))
love.graphics.polygon("fill",ri.b:getWorldPoints(ri.s:getPoints()))
love.graphics.polygon("fill",fu.b:getWorldPoints(fu.s:getPoints()))
love.graphics.polygon("fill",fd.b:getWorldPoints(fd.s:getPoints()))
love.graphics.circle("fill", c.b:getX(), c.b:getY(), c.s:getRadius())
    if win > 0 then 
    love.graphics.print("Player Ganhou", w/2 , h/2,0,1,1,0,0)
    else if win < 0 then
        love.graphics.print("Computador Ganhou", w/2 , h/2,0,1,1,0,0)
    end
    end
end
-- função para segurar os objetos para não passar objetos pra fora do Y
function hold()
if rp.b:getX() < w/6 then 
rp.b:setX(w/6)
end
if rp.b:getAngle() ~= 0 then
rp.b:setAngle(0)
end
if ri.b:getX() > 6*(w/7) then 
ri.b:setX(6*(w/7))
end
if ri.b:getAngle() ~= 0 then
ri.b:setAngle(0)
end
if rp.b:getY() > h - 50 then 
rp.b:setY(h- 50)
end
if rp.b:getY() < 50 then 
rp.b:setY(50)
end
if ri.b:getY() < 50 then 
ri.b:setY(50)
end
if ri.b:getY() > h - 50 then
ri.b:setY(h-50)
end
if c.b:getY() > h - 10 then
c.b:setY(h- 10)
end
if c.b:getY() < 10 then
c.b:setY(10)
end
end

function whoPoint()

    if pointP > 3 then 
    win = 1
    else if pointC > 3 then
        win = -1
    end
    end

    if c.b:getX() > w +20 then
    restart()
    pointP = pointP +1
    end

    if c.b:getX() < -20 then
    restart()
    pointC = pointC +1
    end

end
--função de reinicio
function restart()
    c.b:setY(h/2)
    c.b:setX(w/2)
    c.b:setLinearVelocity(-300, -50)
    rp.b:setY(h/2)
    ri.b:setY(h/2)
end
-- funçao da ia
function move(dt)
if c.b:getX() > w/2 then
    if c.b:getY() > ri.b:getY() then
    ri.b:setY(ri.b:getY() + 5)
else if c.b:getY() < ri.b:getY() then
    ri.b:setY(ri.b:getY() - 5)
    else
        c.b:getY()
    end
    end
end
end