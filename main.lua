local lg = love.graphics

newStipple = love.filesystem.load 'stipple.lua'

stipples = {newStipple('1111111100000000'), newStipple('11110000'), newStipple('01110101001')}

stipples[4] = require 'stipple'

stipples[4]:setStipple '11110000'
stipples4 = {'11110000', '01111000', '00111100', '00011110', '00001111', '10000111', '11000011', '11100001'}

time = 0

love.update = function(dt)

	time = time + dt
	
end