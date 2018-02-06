local _vector = {}

_vector.mt = {
	__index = function(tbl, key)
		if key == 1 then
			return tbl.x
		elseif key == 2 then
			return tbl.y
		end
	end
}

function _vector.new(x, y)
	x = x or 0
	y = y or 0
	
	local vector = {}
	vector.x = x
	vector.y = y
	
	setmetatable(vector, _vector.mt)
	
	return vector
end

return _vector