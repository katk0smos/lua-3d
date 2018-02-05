local Vector3 = require("classes.vector3")
local Vector2 = require("classes.vector2")
local Color = require("classes.color")
local Camera = require("classes.camera")
local Utility = require("utility")

local verts = {}
local edges = {}
local faces = {}
local colors = {}
local w,h,cx,cy
local cam
local radian = 0

function love.load()
	-- Mouse stuff
	love.mouse.setGrabbed(true)
	love.mouse.setRelativeMode(true)
	
	-- Other things
	w = love.graphics.getWidth()
	h = love.graphics.getHeight()
	cx = w / 2
	cy = h / 2
	love.graphics.setBackgroundColor( 255, 255, 255 ) -- Set clear color
	
	verts = {
		Vector3.new(-1, -1, -1),
		Vector3.new(1, -1, -1),
		Vector3.new(1, 1, -1),
		Vector3.new(-1, 1, -1),
		
		Vector3.new(-1, -1, 1),
		Vector3.new(1, -1, 1),
		Vector3.new(1, 1, 1),
		Vector3.new(-1, 1, 1)
	}
	
	edges = {
		Vector2.new(1,2),
		Vector2.new(2,3),
		Vector2.new(3,4),
		Vector2.new(4,1),
		
		Vector2.new(5,6),
		Vector2.new(6,7),
		Vector2.new(7,8),
		Vector2.new(8,5),
		
		Vector2.new(1,5),
		Vector2.new(2,6),
		Vector2.new(3,7),
		Vector2.new(4,8)
	}
	
	faces = {
		{1, 2, 3, 4},
		{5, 6, 7, 8},
		{1, 2, 6, 5},
		{3, 4, 8, 7},
		{1, 4, 8, 5},
		{2, 3, 7, 6}
	}
	
	colors = {
		Color.new(255, 0,   0),
		Color.new(255, 128, 0),
		Color.new(255, 255, 0),
		Color.new(255, 255, 255),
		Color.new(0,   0,   255),
		Color.new(0,   255, 0)
	}
	
	cam = Camera.new(Vector3.new(0,0, -5))
end

function love.update(dt)
	cam:update(dt)
	radian = radian + dt
end

function love.draw()
	love.graphics.setColor(0,0,0)
	
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	
	--[[
	for i,e in ipairs(edges) do
		local edgeX = e.x
		local edgeY = e.y
		
		local points = {}
		for j,v in ipairs({verts[edgeX], verts[edgeY]}) do
			local x = v.x
			local y = v.y
			local z = v.z
			
			x = x - cam.position.x
			y = y - cam.position.y
			z = z - cam.position.z
			
			local rotatedY = Utility.rotate2D(Vector2.new(x, z), cam.rotation.y)
			x, z = rotatedY.x, rotatedY.y
			local rotatedX = Utility.rotate2D(Vector2.new(y, z), cam.rotation.x)
			y, z = rotatedX.x, rotatedX.y
			
			f = (w/2) / z
			x, y = x*f, y*f
		
			table.insert(points, x + cx)
			table.insert(points, y + cy)
		end
		
		if #points >= 2 then
			love.graphics.line(points)
		end
	end
	]]--
	
	local vertList, screenCoords = {}, {}
	for i,v in ipairs(verts) do
		local x = v.x
		local y = v.y
		local z = v.z
		x = x - cam.position.x
		y = y - cam.position.y
		z = z - cam.position.z
		local rotatedY = Utility.rotate2D(Vector2.new(x, z), cam.rotation.y)
		x, z = rotatedY.x, rotatedY.y
		local rotatedX = Utility.rotate2D(Vector2.new(y, z), cam.rotation.x)
		y, z = rotatedX.x, rotatedX.y
		
		table.insert(vertList, Vector3.new(x, y, z))
		
		f = (w/2) / z
		x, y = x*f, y*f
	
		table.insert(screenCoords, Vector2.new(x + cx, y + cy))
	end
	
	local faceList = {}
	local faceColor = {}
	local depth = {}
	for i, face in ipairs(faces) do
		local onScreen = false
		for j,vert in ipairs(face) do
			if vertList[vert].z > 0 then
				onScreen = true
				break
			end
		end
		
		if onScreen then
			local coords = {}
			for j,v in ipairs(face) do
				table.insert(coords, screenCoords[v])
			end
			
			table.insert(faceList, coords)
			table.insert(faceColor, colors[i])
		end
	end
	
	for i,v in pairs(faceList) do
		love.graphics.setColor(faceColor[i].red or 0, faceColor[i].green or 0, faceColor[i].blue or 0)
		
		local points = {}
		for j,p in pairs(v) do
			table.insert(points, p.x)
			table.insert(points, p.y)
		end
		love.graphics.polygon("fill", points)
	end
	
end

function love.mousemoved(x, y, dx, dy, isTouch)
	cam:mouse(dx, dy)
end

function love.keypressed(key, scancode, isRepeat)
	if scancode == "escape" then
		love.event.quit()
	end
end




