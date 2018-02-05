local _vector = {}

function _vector.new(x, y)
	x = x or 0
	y = y or 0
	
	local vector = {}
	vector.x = x
	vector.y = y
	
	return vector
end

return _vector