--local utils = require "utils"
local ship = require "ship"
local particles = require "particles"
wid = love.graphics.getWidth()
hei = love.graphics.getHeight()
lr,lg,lb = 0,0,0
lir = 0

function love.load()
	ship = ship.novo ()
	particles = particles.novo()
end
function love.resize(w, h)
end

function love.draw()

	love.graphics.draw(particles.pSys, wid/2, 20)


	xa = 0
	lir = 1
	if dir == -1 then
    	xa = 32
    	lir = -1
	end

	barwidth = 28
	hpb = barwidth-2
	px = ship.posX - (ship.width/2) + ((barwidth-1)/2) + 5

	size = ship.hp / ship.mhp
	size = size * hpb
	love.graphics.draw(ship.pref, ship.frame,ship.posX+xa,ship.posY,0, lir, 1)
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", px, ship.posY + ship.width + 20,barwidth,10)
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill", px+1, ship.posY + ship.width + 21,size,8)

	love.graphics.setColor(255,255,255)
	for i, tiro in pairs(ship.tiros) do
		love.graphics.draw(ship.pref, tiro.img, tiro.x + ship.origX, tiro.y)
	end
end

function love.mousePressed()
    	particles.pSys:emit(3)
end
function love.update(dt)
	particles.spawnTime = particles.spawnTime - 1 * dt
	if particles.spawnTime <= 0 then
		love.mousePressed()
		particles.spawnTime = particles.spawnMax
	end
	particles.pSys:update(dt)
	canMove = false
    if ship.posX > 0 then
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            dir = -1  
            canMove = true  
        end
    end
    if ship.posX < wid - ship.width then
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then  
            dir = 1
            canMove = true
        end
    end
    if love.keyboard.isDown("right") ==false  and love.keyboard.isDown("d") ==false  and love.keyboard.isDown("left")==false  and love.keyboard.isDown("a")==false then
    	dir = 0
    end
    if love.keyboard.isDown("e") and ship.hp > 0 then--hurt ship test
    	if ship.hp <= 0 then
    		ship.hp = 0
    	end
    	ship.hp = ship.hp - 1
    end
    ship.move(dir, dt, canMove)
    if love.keyboard.isDown("space") and ship.atira then
		novotiro = {x = ship.posX, y = ship.posY, img = ship.imgtiro}
		table.insert(ship.tiros, novotiro)
		ship.atira = false
		ship.tempoatipo = ship.delaytiro
	end
	ship.atirar(dt)
end
function love.keypressed(key, scancode, isrepeat)
	if (key == "escape") then
		love.event.quit(0)
   	end
end