local Vector3 = require("classes.vector3")
local Vector2 = require("classes.vector2")

local _camera = {}

function _camera.new(pos, rot)
	pos = pos or Vector3.new(0,0,0)
	rot = rot or Vector3.new(0,0,0)
	
	local camera = {}
	camera.position = pos
	camera.rotation = rot
	
	function camera:update(dt)
		local s = dt*10
		
		local x, z = s*math.sin(self.rotation.y), s*math.cos(self.rotation.y)
		
		if love.keyboard.isDown("w") then
			self.position.x = self.position.x + x
			self.position.z = self.position.z + z
		end
		if love.keyboard.isDown("s") then
			self.position.x = self.position.x - x
			self.position.z = self.position.z - z
		end
		if love.keyboard.isDown("a") then
			self.position.x = self.position.x - z
			self.position.z = self.position.z + x
		end
		if love.keyboard.isDown("d") then
			self.position.x = self.position.x + z
			self.position.z = self.position.z - x
		end
		
		
		if love.keyboard.isDown("q") then
			self.position.y = self.position.y + s
		end
		if love.keyboard.isDown("e") then
			self.position.y = self.position.y - s
		end
	end
	
	function camera:mouse(x, y)
		local x, y = x / 200, y / 200
		self.rotation.x = self.rotation.x + y --math.max(math.min(self.rotation.x + y, math.pi - 0.0001), -math.pi + 0.0001)
		self.rotation.y = self.rotation.y + x --math.max(math.min(self.rotation.y + x, math.pi/2 - 0.0001), -math.pi/2 + 0.0001)
	end
	
	return camera
end

return _camera