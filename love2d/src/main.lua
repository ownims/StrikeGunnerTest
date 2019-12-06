local utils = require "utils"
local game = require "game"
ship = love.graphics.newImage("ship.png")--6x56--21x29
--ship = loadTransparent("ship.png", 163,73,164)
shipIdle = love.graphics.newQuad(6,56,22,29, ship:getDimensions())
wid = love.graphics.getWidth()
hei = love.graphics.getHeight()
origX = 11
posX = 150-origX
posY = hei-29
lr,lg,lb = 0,0,0

function love.load()
	print("\ngame started")
	utils.teste()
	ship = loadTransparent("ship.png", 163,73,164)
	atira = true
	delaytiro = .1
	tempoatipo = delaytiro
	tiros = {}
	imgtiro = love.graphics.newQuad(114,48,6,6, ship:getDimensions())

end
function makeTransparent(x, y, r, g, b, a)
   if r == lr and g == lg and b == lb then
     a = 0
   end
   return r,g,b,a
end
function loadTransparent(imagePath, transR, transG, transB)
	imageData = love.image.newImageData( imagePath )
	lr,lg,lb = imageData:getPixel(0,0)
	imageData:mapPixel(makeTransparent)
	--function mapFunction(x, y, r, g, b, a)
--	-	if r == transR and g == transG and b == transB then a = 0 end-
--		return r,g,b,a
--	end
	--imageData:mapPixel( mapFunction )
	return love.graphics.newImage( imageData )
end
function love.resize(w, h)
end

function love.draw()
    love.graphics.draw(ship, shipIdle,posX,posY)
	for i, tiro in ipairs(tiros) do
		love.graphics.draw(ship, tiro.img,tiro.x+origX-3,tiro.y)
	end
end

function love.update(dt)
    if posX > 0 then
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            posX = posX-100*dt        
        end
    end
    if posX < wid - 2*origX then
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            posX = posX+100*dt        
        end
    end
    if love.keyboard.isDown("space") and atira then
		novotiro = {x = posX, y = posY, img = imgtiro}
		table.insert(tiros, novotiro)
		atira = false
		tempoatipo = delaytiro
	end
	atirar(dt)
end
function atirar(dt)
	tempoatipo = tempoatipo - 1*dt
	if tempoatipo < 0 then
		atira = true
	end
	
	for i, tiro in ipairs(tiros) do
		tiro.y = tiro.y - (500*dt)
		if tiro.y < 0 then
			table.remove(tiros, i)
		end
	end
end
function love.keypressed(key, scancode, isrepeat)
	if (key == "escape") then
		love.event.quit(0)
   	end
end