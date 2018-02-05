local Vector3 = require("classes.vector3")
local Vector2 = require("classes.vector2")

local _utility = {}

function _utility.rotate2D(pos, radians)
	x, y = pos.x, pos.y
	s,c = math.sin(radians), math.cos(radians)
	
	return Vector2.new(x*c-y*s,y*c+x*s)
end

return _utility