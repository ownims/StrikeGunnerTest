local enemy = {}

function enemy.novo ()

	local _enemy = {}
	_enemy.hp = 5
	_enemy.mhp = 5
	_enemy.img = love.graphics.
	_enemy.frameMax = 10
	_enemy.frameCount = 0
	_enemy.pref = loadTransparent("ship.png")
	_enemy.width = 32
	_enemy.origX = _enemy.width/2
	_enemy.posX = (wid/2) - (_enemy.width/2)
	_enemy.posY = hei-_enemy.width-50
	_enemy.img = love.graphics.newQuad(0,53,32,32, _enemy.pref:getDimensions())
	_enemy.imgMove0 = love.graphics.newQuad(36,53,32,32, _enemy.pref:getDimensions())
	_enemy.imgMove1 = love.graphics.newQuad(60,53,32,32, _enemy.pref:getDimensions())
	_enemy.imgtiro = love.graphics.newQuad(114,48,6,6, _enemy.pref:getDimensions())
	_enemy.frame = _enemy.img
	_enemy.speed = 200
	_enemy.atira = true
	_enemy.delaytiro = 0.1
	_enemy.tempoatipo = _enemy.delaytiro
	_enemy.dir = 0
	_enemy.tiros = {}
	function _enemy.atirar (dt) 
		_enemy.tempoatipo = _enemy.tempoatipo - 1*dt
		if _enemy.tempoatipo < 0 then
			_enemy.atira = true
		end
		
		for i, tiro in ipairs(_enemy.tiros) do
			tiro.y = tiro.y - (500*dt)
			if tiro.y < 0 then
				table.remove(_enemy.tiros, i)
			end
		end
	end
	function _enemy.move(key, dt, canMove)
		if _enemy.dir == key then
			_enemy.frameCount = _enemy.frameCount + 1
		end
		if _enemy.dir ~= key then
			_enemy.frameCount = 0
		end
		if key == 0 then
			_enemy.frame =  _enemy.img
		end
		if key == -1 or key == 1 then
			if canMove then
				_enemy.posX = _enemy.posX+(_enemy.speed*key)*dt 
			end
			if _enemy.frameCount < _enemy.frameMax then
				_enemy.frame = _enemy.imgMove0
			end
			if _enemy.frameCount >= _enemy.frameMax then
				_enemy.frame = _enemy.imgMove1
			end
		end
		_enemy.dir = key
	end
	return _enemy
end

return enemy