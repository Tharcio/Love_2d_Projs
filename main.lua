function love.load()
love.window.setTitle("Pinball")
w,h = love.graphics.getDimensions()
world = love.physics.newWorld(0,0, true)
c = {}
rp,ri = {},{}
c.b = love.physics.newBody(world,w/2,h/2,"dynamic")
c.s = love.physics.newCircleShape(10)
c.f = love.physics.newFixture(c.b, c.s, 0.5)
c.f:setRestitution(1)
rp.b = love.physics.newBody(world,w/6, h/2,"dynamic")
rp.s = love.physics.newRectangleShape(15,100)
rp.f = love.physics.newFixture(rp.b, rp.s, 100)
rp.f:setRestitution(1)
ri.b = love.physics.newBody(world,5*(w/6), h/2,"dynamic")
ri.s = love.physics.newRectangleShape(15,100)
ri.f = love.physics.newFixture(ri.b, ri.s, 100)
ri.f:setRestitution(1)
end

function love.update(d)
world:update(d)
hold()
if love.keyboard.isDown("up") then
 rp.b:applyForce(0, -400)
end
if love.keyboard.isDown("down") then
 rp.b:applyForce(0, 400)
end
end

function love.draw()
love.graphics.polygon("fill",rp.b:getWorldPoints(rp.s:getPoints()))
love.graphics.polygon("fill",ri.b:getWorldPoints(ri.s:getPoints()))
love.graphics.circle("fill", c.b:getX(), c.b:getY(), c.s:getRadius())
end


function hold()
if rp.b:getY() > h then 
rp.b:setY(h)
end
if rp.b:getY() < 0 then 
rp.b:setY(0)
end
if ri.b:getY() < 0 then 
ri.b:setY(0)
end
if ri.b:getY() > h then
ri.b:setY(h)
end
end