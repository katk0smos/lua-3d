local _vector = {}

_vector.mt = {
	__index = function(tbl, key)
		if key == 1 then
			return tbl.x
		elseif key == 2 then
			return tbl.y
		elseif key == 3 then
			return tbl.z
		end
	end
}

function _vector.new(x, y, z)
	x = x or 0
	y = y or 0
	z = z or 0
	
	local vector = {}
	vector.x = x
	vector.y = y
	vector.z = z
	
	setmetatable(vector, _vector.mt)
	
	return vector
end

return _vector