-- @Author: Alan
-- @Date:   2016-11-09 15:10:17
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 21:34:28

local Set = {}
local mt = {}
Set.new = function ( l )
	local set = {}
	setmetatable(set, mt)
	for _, v in pairs(l) do
		set[v] = true
	end
	return set
end

mt.__tostring = function ( set )
	local l = {}
	for e in pairs(set) do
		l[#l + 1] = e
	end
	return "{".. table.concat( l, ", " ) .. "}"
end

mt.__metatable = "not your business"

s1 = Set.new{10, 4, 5}
print (s1)
print (getmetatable(s1))
-- print (assert(setmetatable(s1, {})))