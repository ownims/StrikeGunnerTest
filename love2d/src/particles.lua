--particles
local particles = {}

function particles.novo()
	aleatorio = love.math.random( 5,10)
	spawnRnd = love.math.random( 5,10)
	local _particles = {}
	_particles.img = love.graphics.newImage( "particle.png" )
	_particles.posX = aleatorio
	_particles.spawnTime = 0
	_particles.spawnMax = 2
	_particles.pSys = love.graphics.newParticleSystem(_particles.img, 8)
	_particles.pSys:setParticleLifetime(1,20)
	_particles.pSys:setLinearAcceleration(0,20,0,0)
	return _particles
end



return particles
