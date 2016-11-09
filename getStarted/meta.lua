-- @Author: Alan
-- @Date:   2016-11-09 15:14:07
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 21:20:16

Set = {}
mt = {}

function Set.new( l )
	local set = {}
	setmetatable(set, mt)
	for _, v in pairs(l) do
		set[v] = true
	end
	return set
end

function Set.union( a, b )
	local set = Set.new{}
	for k in pairs(a) do
		set[k] = true
	end
	for k in pairs(b) do
		set[k] = true
	end
	return set
end

function Set.intersection(a, b)
	local set = Set.new{}
	for k in pairs(a) do
		set[k] = b[k]
	end
	return set
end

function Set.tostring( set )
	local l = {}				-- 用于存放集合中所有元素的列表
	for e in pairs(set) do
		l[#l + 1] = e
	end
	return "{" .. table.concat(l, ', ') .. "}"
end

function Set.print( s )
	print (Set.tostring(s))
end

mt.__add = Set.union
mt.__mul = Set.intersection
mt.__tostring = Set.tostring
mt.__metatable = "not your business"

mt.__le = function ( a, b )
	for k in pairs(a) do
		if not b[k] then return false end
	end
	return true
end

mt.__lt = function ( a, b )
	return a <= b and not (b <= a)
end

mt.__eq = function ( a, b )
	return a <= b and b <= a
end

return Set

