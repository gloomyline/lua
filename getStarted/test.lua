-- @Author: Alan
-- @Date:   2016-11-07 08:53:05
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 17:27:55
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