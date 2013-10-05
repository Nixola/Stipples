local lg = love.graphics

newStipple = love.filesystem.load 'stipple.lua'

stipples = {newStipple('1111111100000000'), newStipple('11110000'), newStipple('01110101001')}

stipples[4] = require 'stipple'

stipples[4]:setStipple '11110000'
stipples4 = {'11110000', '01111000', '00111100', '00011110', '00001111', '10000111', '11000011', '11100001'}
stipples4i = 1

time = 0

love.update = function(dt)

	time = time + dt
	
	if time > 0.05 then
	
		stipples4i = stipples4i>7 and 1 or stipples4i+1
		
		time = time - 0.05
		
	end
	
	stipples[4]:setStipple(stipples4[stipples4i])
		
end

love.draw = function()

	local x, y = love.mouse.getPosition()
	
	
	lg.setColor {255,0,0}
	stipples[1]:draw(400, 300, 800-x, 600-y)
	
	lg.setColor {0, 255,0}
	stipples[2]:draw(400, 300, 800-x, y)
	
	lg.setColor {0, 0, 255}
	stipples[3]:draw(400, 300, x, 600-y)
	
	lg.setColor{255,255,255}
	stipples[4]:draw(400, 300, x, y)
	
end