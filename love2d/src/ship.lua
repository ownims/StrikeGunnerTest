local ship = {}
lr,lg,lb = 0,0,0


function ship.novo ()	
	wid = love.graphics.getWidth()
	hei = love.graphics.getHeight()
	local _ship = {}
	_ship.mhp = 10.0
	_ship.hp = 10.0
	_ship.frameMax = 10
	_ship.frameCount = 0
	_ship.pref = loadTransparent("ship.png")
	_ship.width = 32
	_ship.origX = _ship.width/2
	_ship.posX = (wid/2) - (_ship.width/2)
	_ship.posY = hei-_ship.width-50
	_ship.img = love.graphics.newQuad(0,53,32,32, _ship.pref:getDimensions())
	_ship.imgMove0 = love.graphics.newQuad(36,53,32,32, _ship.pref:getDimensions())
	_ship.imgMove1 = love.graphics.newQuad(60,53,32,32, _ship.pref:getDimensions())
	_ship.imgtiro = love.graphics.newQuad(114,48,6,6, _ship.pref:getDimensions())
	_ship.frame = _ship.img
	_ship.speed = 200
	_ship.atira = true
	_ship.delaytiro = 0.1
	_ship.tempoatipo = _ship.delaytiro
	_ship.dir = 0
	_ship.tiros = {}
	function _ship.atirar (dt) 
		_ship.tempoatipo = _ship.tempoatipo - 1*dt
		if _ship.tempoatipo < 0 then
			_ship.atira = true
		end
		
		for i, tiro in ipairs(_ship.tiros) do
			tiro.y = tiro.y - (500*dt)
			if tiro.y < 0 then
				table.remove(_ship.tiros, i)
			end
		end
	end
	function _ship.move(key, dt, canMove)
		if _ship.dir == key then
			_ship.frameCount = _ship.frameCount + 1
		end
		if _ship.dir ~= key then
			_ship.frameCount = 0
		end
		if key == 0 then
			_ship.frame =  _ship.img
		end
		if key == -1 or key == 1 then
			if canMove then
				_ship.posX = _ship.posX+(_ship.speed*key)*dt 
			end
			if _ship.frameCount < _ship.frameMax then
				_ship.frame = _ship.imgMove0
			end
			if _ship.frameCount >= _ship.frameMax then
				_ship.frame = _ship.imgMove1
			end
		end
		_ship.dir = key
	end
	return _ship
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