-- @Author: Alan
-- @Date:   2016-11-09 14:14:11
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-09 15:02:24


local meta = require('../arithmetic_metamethod')
-- local mt = {}
-- print (meta.Set, meta.mt)
local Set = meta.Set
local mt = meta.mt

print (string.rep('*', 10))

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

s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
print (s1 <= s2, s1 < s2, s1 >= s1, s1 > s1, s1 == s2 * s1)