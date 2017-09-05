
win = 0
function love.load()
love.window.setTitle("Pinball")
w,h = love.graphics.getDimensions()
world = love.physics.newWorld(0,0, true)
pointP,pointC = 0,0
c = {}
rp,ri = {},{}
c.b = love.physics.newBody(world,w/2,h/2,"dynamic")
c.s = love.physics.newCircleShape(10)
c.f = love.physics.newFixture(c.b, c.s, 0.5)
c.f:setRestitution(0.5)
c.b:isBullet()
rp.b = love.physics.newBody(world,w/6, h/2,"dynamic")
rp.s = love.physics.newRectangleShape(15,100)
rp.f = love.physics.newFixture(rp.b, rp.s, 10)
rp.f:setRestitution(1.1)
ri.b = love.physics.newBody(world,5*(w/6), h/2,"dynamic")
ri.s = love.physics.newRectangleShape(15,100)
ri.f = love.physics.newFixture(ri.b, ri.s, 10)
ri.f:setRestitution(1.1)
c.b:setLinearVelocity(400, 0)
end

function love.update(dt)
dt = 1/40
world:update(dt)

hold()
whoPoint()
if love.keyboard.isDown("up") then
 rp.b:applyForce(0, -1000)
end
if love.keyboard.isDown("down") then
 rp.b:applyForce(0, 1000)
end
end

function love.draw()
love.graphics.polygon("fill",rp.b:getWorldPoints(rp.s:getPoints()))
love.graphics.polygon("fill",ri.b:getWorldPoints(ri.s:getPoints()))
love.graphics.circle("fill", c.b:getX(), c.b:getY(), c.s:getRadius())
    if win > 0 then 
    love.graphics.print("Player Ganhou", w/2 , h/2,0,1,1,0,0)
    else if win < 0 then
        love.graphics.print("Computador Ganhou", w/2 , h/2,0,100,20,0,0)
    end
    end
end

function hold()
if rp.b:getX() < w/6 then 
rp.b:setX(w/6)
end
if rp.b:getAngle() ~= 0 then
rp.b:setAngle(0)
end
if ri.b:getX() > 5*(w/6) then 
ri.b:setX(5*(w/6))
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

    --c.b:setAngularVelocity(200)
    if c.b:getX() > w +20 then
    c.b:setY(h/2)
    c.b:setX(w/2)
    c.b:setLinearVelocity(-500, 0)
    pointC = pointC +1
    end

    if c.b:getX() < -20 then
    c.b:setY(h/2)
    c.b:setX(w/2)
    c.b:setLinearVelocity(500, 0)
    pointP = pointP +1
    end
end