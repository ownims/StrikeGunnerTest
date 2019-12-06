local ship = {}
lr,lg,lb = 0,0,0


function ship.novo ()
	
	wid = love.graphics.getWidth()
	hei = love.graphics.getHeight()
	local _ship = {}
	_ship.pref = loadTransparent("ship.png")
	_ship.width = 32
	_ship.origX = 16
	_ship.posX = (wid/2) - 16
	_ship.posY = hei-29
	_ship.img = love.graphics.newQuad(0,53,32,32, _ship.pref:getDimensions())
	_ship.imgMove0 = love.graphics.newQuad(36,53,32,32, _ship.pref:getDimensions())
	_ship.imgMove1 = love.graphics.newQuad(60,53,32,32, _ship.pref:getDimensions())

	_ship.frame = _ship.img

	return _ship
end

function game(x)
	--PRINT
    print("\ngame started")
end


function makeTransparent(x, y, r, g, b, a)
   if r == lr and g == lg and b == lb then
     a = 0
   end
   return r,g,b,a
end
function loadTransparent(imagePath)
	imageData = love.image.newImageData( imagePath )
	lr,lg,lb = imageData:getPixel(0,0)
	imageData:mapPixel(makeTransparent)
	return love.graphics.newImage( imageData )
end

return ship