local lg = love.graphics
lg.setFont(lg.newFont(8))

newStipple = love.filesystem.load 'stipple.lua'

stipples = {newStipple('1111111100000000'), newStipple('11110000'), newStipple('01110101001'), newStipple '11110000'}

rect = {10, 10, 10, 60, 60, 60, 60, 10, stipple = newStipple '11111111111111111111111110000000000000000000000000'}

time = 0

love.update = function(dt)

	time = time + dt
	
	if time > 0.05 then
	
		stipples[4]:next()
		rect.stipple:prev()
		
		time = time - 0.05
		
	end
		
end

love.draw = function()

	local x, y = love.mouse.getPosition()
	
	
	lg.setColor {255,0,0}
	stipples[1]:draw(400, 300, 800-x, 600-y)
	
	lg.setColor {0, 255,0}
	stipples[2]:draw(400, 300, 800-x, y)
	
	lg.setColor {0, 0, 255}
	stipples[3]:draw(400, 300, x, 600-y)
	
	lg.setColor {255,255,255}
	stipples[4]:draw(400, 300, x, y)

	lg.setColor {255,255,0}
	for i = 1, #rect/2 do
		lg.print(i, rect[i*2-1], rect[i*2])
		if i == #rect/2 then
			rect.stipple:draw(rect[i*2-1], rect[i*2], rect[1], rect[2])
		else
			rect.stipple:draw(rect[i*2-1], rect[i*2], rect[i*2+1], rect[i*2+2])
		end
	end

	
end