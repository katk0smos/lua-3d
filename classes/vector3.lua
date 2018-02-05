local _vector = {}

function _vector.new(x, y, z)
	x = x or 0
	y = y or 0
	z = z or 0
	
	local vector = {}
	vector.x = x
	vector.y = y
	vector.z = z
	
	return vector
end

return _vector