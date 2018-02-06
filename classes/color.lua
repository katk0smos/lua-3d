local _color = {}

_color.mt = {
	__index = function(tbl, key)
		if key == 1 then
			return tbl.red
		elseif key == 2 then
			return tbl.green
		elseif key == 3 then
			return tbl.blue
		end
	end
}

function _color.new(r, g, b)
	local color = {}
	color.red = r
	color.green = green
	color.blue = blue
	
	setmetatable(color, _color.mt)
	
	return color
end

return _color