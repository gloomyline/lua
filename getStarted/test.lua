-- @Author: Alan
-- @Date:   2016-11-07 08:53:05
-- @Last Modified by:   gloomy
-- @Last Modified time: 2016-11-09 21:21:16


local Set = require('./meta')

function testFunc( str )
	-- body
	print (str)
end

-- testFunc('Hello, World!')

tab1 = {key1 = 'val1', key2 = 'val2', 'val3'}
for k, v in pairs(tab1) do
	print (k .. '-' .. v)
end

tab1.key1 = nil
for k, v in pairs(tab1) do
	print (k .. '-' .. v)
end

io.write("{1, 2, 3, 4}")

print (string.format(1, 2, 3, 4))

local s1 = Set.new{1, 10, 20, 30, 40}
local s2 = Set.new{10, 30, 50}
print (s1 + s2)
print (s1 * s2)
