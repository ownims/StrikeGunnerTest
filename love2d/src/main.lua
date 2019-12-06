local utils = require "utils"
local ship = require "ship"
wid = love.graphics.getWidth()
hei = love.graphics.getHeight()
lr,lg,lb = 0,0,0
lir = 0

function love.load()
	ship = ship.novo ()
	
	
end
function love.resize(w, h)
end

function love.draw()
	xa = 0
	lir = 1
	if dir == -1 then
    	xa = 32
    	lir = -1
	end
	love.graphics.draw(ship.pref, ship.frame,ship.posX+xa,ship.posY,0, lir, 1)
	love.graphics.setColor(128,19,54)
	love.graphics.rectangle("fill", ship.posX, ship.posY + ship.width + 20,32,10)

	for i, tiro in pairs(ship.tiros) do
		love.graphics.draw(ship.pref, tiro.img, tiro.x + ship.origX, tiro.y)
	end
end

function love.update(dt)
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