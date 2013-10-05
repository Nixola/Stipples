local stipple = {}

local args = {...}



local dist = function(x1, y1, x2, y2) return ((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))^.5 end

local imgD = love.image.newImageData(1,8)
imgD:mapPixel(function() return 255,255,255,255 end)

stipple.img = love.graphics.newImage(imgD)
stipple.img:setWrap('repeat', 'repeat')

stipple.quad = love.graphics.newQuad(0,0,1,8,1,8)

imgD = nil

stipple.draw = function(self, x1, y1, x2, y2)

	local d = dist(x1,y1,x2,y2)

	local v = {self.quad:getViewport()}

	self.quad:setViewport(v[1], v[2], v[3], d)

	local a = math.atan2(y2-y1, x2-x1)-math.pi/2

	love.graphics.drawq(self.img, self.quad, x1, y1, a)

end


stipple.stipples = {}


stipple.setStipple = function(self, stipple)

	if not (type(stipple) == 'number' or (type(stipple) == 'string' and tonumber(stipple))) then
	
		error("Wrong stipple type - binary string expected, got "..type(stipple))
		
	end
	
	stipple = tostring(stipple)
	
	if stipple:find "[23456789%.]" then
	
		error "Invalid stipple - integral binary string expected, found other figures"
		
	end
	
	local h = #stipple
	
	if not self.stipples[stipple] then
	
		local imgD = love.image.newImageData(1, h)
		
		for i = 1, h do
		
			local v = stipple:sub(i,i)
		
			imgD:setPixel(0, i-1, v*255, v*255, v*255, v*255)
			
		end
		
		self.stipples[stipple] = {img = love.graphics.newImage(imgD), quad = love.graphics.newQuad(0,0,1,h,1,h)}
		self.stipples[stipple].img:setWrap('repeat', 'repeat')
		
	end
	
	self.img = self.stipples[stipple].img
	self.quad = self.stipples[stipple].quad
	
end

if tonumber(args[1]) and not args[1]:find "[23456789%.]" then

	stipple:setStipple(tostring(args[1]))
	
end

return stipple
