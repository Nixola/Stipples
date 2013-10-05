local stipple = {}

local dist = function(x1, y1, x2, y2) return ((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))^.5 end

stipple.img = love.graphics.newImage 'stipple/stipple.png'
stipple.img:setWrap('repeat', 'repeat')

stipple.quads = {
	love.graphics.newQuad(0, 0, 1, 8, 8, 8),
	love.graphics.newQuad(1, 0, 1, 8, 8, 8),
	love.graphics.newQuad(2, 0, 1, 8, 8, 8),
	love.graphics.newQuad(3, 0, 1, 8, 8, 8),
	love.graphics.newQuad(4, 0, 1, 8, 8, 8),
	love.graphics.newQuad(5, 0, 1, 8, 8, 8),
	love.graphics.newQuad(6, 0, 1, 8, 8, 8),
	love.graphics.newQuad(7, 0, 1, 8, 8, 8)}

stipple.current = 1
stipple.quad = stipple.quads[1]

stipple.next = function(self)

	self.current = self.current + 1
	if self.current > 8 then
		self.current = 1
	end
	self.quad = self.quads[self.current]

end


stipple.draw = function(self, x1, y1, x2, y2)

	local d = dist(x1,y1,x2,y2)

	local v = {self.quad:getViewport()}

	self.quad:setViewport(v[1], v[2], v[3], d)

	local a = math.atan2(y2-y1, x2-x1)-math.pi/2

	love.graphics.drawq(self.img, self.quad, x1, y1, a)

end


stipple.stipples = {}


stipple.setStipple = function(self, stipple)

	if not (type(stipple) == 'number' or (type(stipple) == 'string' and tonumber(stipple)) then
	
		error("Wrong stipple type - binary string expected, got "..type(stipple))
		
	end
	
	stipple = tostring(stipple)
	
	if stipple:find "[23456789%.]" then
	
		error "Invalid stipple - integral binary string expected, found other figures"
		
	end
	
	local h = #stipple
	
	if not self.stipples[stipple] then
	
		local imgD = love.graphics.newImageData(1, h)
		
		for i = 1, h do
		
			local v = stipple:sub(i,i)
		
			imgD:setPixel(0, i-1, v*255, v*255, v*255, v*255)
			
		end
		
		self.stipples[stipple] = {img = love.graphics.newImage(imgD)}
		
		--go on?

return stipple
